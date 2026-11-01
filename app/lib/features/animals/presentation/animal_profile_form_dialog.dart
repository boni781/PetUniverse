import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../species/data/species_repository.dart';
import '../data/animal_repository.dart';

class AnimalProfileDraft {
  const AnimalProfileDraft({
    required this.name,
    required this.isGroup,
    required this.attributeValues,
    this.speciesId,
    this.notes,
    this.sexCode,
    this.birthDate,
    this.birthDatePrecision,
    this.acquiredAt,
    this.lifeStageCode,
    this.groupPurpose,
    this.memberTrackingMode = 'not_tracked',
    this.reportedCount,
    this.countObservedAt,
    this.countNote,
  });

  final String name;
  final bool isGroup;
  final String? speciesId;
  final String? notes;
  final String? sexCode;
  final DateTime? birthDate;
  final String? birthDatePrecision;
  final DateTime? acquiredAt;
  final String? lifeStageCode;
  final String? groupPurpose;
  final String memberTrackingMode;
  final int? reportedCount;
  final DateTime? countObservedAt;
  final String? countNote;
  final Map<String, Object?> attributeValues;
}

class AnimalProfileFormDialog extends StatefulWidget {
  const AnimalProfileFormDialog({
    required this.database,
    required this.workspaceId,
    this.initialDetail,
    super.key,
  });

  final AppDatabase database;
  final String workspaceId;
  final AnimalProfileDetail? initialDetail;

  @override
  State<AnimalProfileFormDialog> createState() =>
      _AnimalProfileFormDialogState();
}

class _AnimalProfileFormDialogState extends State<AnimalProfileFormDialog> {
  static const _noSpecies = '__no_species__';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  final _sexController = TextEditingController();
  final _lifeStageController = TextEditingController();
  final _groupPurposeController = TextEditingController();
  final _countController = TextEditingController();
  final _countNoteController = TextEditingController();

  late final SpeciesRepository _speciesRepository;
  List<SpeciesData> _species = [];
  List<SpeciesAttributeDefinition> _definitions = [];
  final Map<String, Object?> _attributeValues = {};
  final Map<String, String> _numericInputs = {};
  final Set<String> _touchedAttributeIds = {};
  bool _initialAttributeValuesApplied = false;

  String? _selectedSpeciesId;
  String _memberTrackingMode = 'not_tracked';
  DateTime? _birthDate;
  DateTime? _acquiredAt;
  DateTime? _countObservedAt;
  String? _birthDatePrecision = 'exact';
  bool _isGroup = false;
  bool _speciesLoading = true;
  bool _attributesLoading = false;
  bool _isCreatingSpecies = false;
  bool _isCreatingAttribute = false;

  @override
  void initState() {
    super.initState();
    _speciesRepository = SpeciesRepository(widget.database);
    _populateProfileFields();
    _loadSpecies();
  }

  void _populateProfileFields() {
    final detail = widget.initialDetail;
    if (detail == null) return;

    final profile = detail.profile;
    _nameController.text = profile.displayName;
    _notesController.text = profile.notes ?? '';
    _isGroup = profile.recordKind == 'group';
    _selectedSpeciesId = profile.speciesId;

    if (_isGroup) {
      final group = detail.groupDetails;
      _groupPurposeController.text = group?.groupPurpose ?? '';
      _memberTrackingMode = group?.memberTrackingMode ?? 'not_tracked';
      if (group?.reportedCount != null) {
        _countController.text = group!.reportedCount.toString();
      }
      _countObservedAt = _localDate(group?.countObservedAt);
      _countNoteController.text = group?.countNote ?? '';
    } else {
      final individual = detail.individualDetails;
      _sexController.text = individual?.sexCode ?? '';
      _lifeStageController.text = individual?.lifeStageCode ?? '';
      _birthDate = _localDate(individual?.birthDate);
      _birthDatePrecision = individual?.birthDatePrecision ?? 'unknown';
      _acquiredAt = _localDate(individual?.acquiredAt);
    }
  }

  DateTime? _localDate(DateTime? value) {
    if (value == null) return null;
    final local = value.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _sexController.dispose();
    _lifeStageController.dispose();
    _groupPurposeController.dispose();
    _countController.dispose();
    _countNoteController.dispose();
    super.dispose();
  }

  Future<void> _loadSpecies({String? selectId}) async {
    setState(() => _speciesLoading = true);
    try {
      final species = await _speciesRepository
          .watchAvailableSpecies(widget.workspaceId)
          .first;
      if (!mounted) return;
      setState(() {
        _species = species;
        _speciesLoading = false;
        if (selectId != null) {
          _selectedSpeciesId = selectId;
        } else if (_selectedSpeciesId != null &&
            !species.any((item) => item.id == _selectedSpeciesId)) {
          _selectedSpeciesId = null;
        }
      });
      await _loadAttributeDefinitions();
    } catch (error) {
      if (!mounted) return;
      setState(() => _speciesLoading = false);
      _showMessage('Katalog spesies belum dapat dibaca: $error');
    }
  }

  Future<void> _selectSpecies(String? value) async {
    setState(() {
      _selectedSpeciesId = value == _noSpecies ? null : value;
      _definitions = [];
      _attributeValues.clear();
      _numericInputs.clear();
      _touchedAttributeIds.clear();
    });
    await _loadAttributeDefinitions();
  }

  Future<void> _loadAttributeDefinitions() async {
    final speciesId = _selectedSpeciesId;
    if (speciesId == null) {
      if (mounted) {
        setState(() {
          _definitions = [];
          _attributesLoading = false;
        });
      }
      return;
    }

    setState(() => _attributesLoading = true);
    try {
      final definitions = await _speciesRepository
          .watchAttributeDefinitions(speciesId)
          .first;
      if (!mounted) return;
      final allowedKind = _isGroup ? 'group' : 'individual';
      final applicableDefinitions = definitions
          .where(
            (definition) =>
                definition.appliesTo == 'both' ||
                definition.appliesTo == allowedKind,
          )
          .toList(growable: false);
      setState(() {
        _definitions = applicableDefinitions;
        _attributesLoading = false;

        final initialDetail = widget.initialDetail;
        if (!_initialAttributeValuesApplied && initialDetail != null) {
          for (final attribute in initialDetail.attributes) {
            final definition = applicableDefinitions
                .where((item) => item.id == attribute.definition.id)
                .firstOrNull;
            if (definition == null || attribute.value == null) continue;

            final id = definition.id;
            if (definition.valueType == 'integer' ||
                definition.valueType == 'decimal' ||
                definition.valueType == 'measurement') {
              _numericInputs[id] = attribute.value.toString();
            } else {
              _attributeValues[id] = attribute.value;
            }
            if (definition.valueType == 'boolean') {
              _touchedAttributeIds.add(id);
            }
          }
          _initialAttributeValuesApplied = true;
        }
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _attributesLoading = false);
      _showMessage('Atribut spesies belum dapat dibaca: $error');
    }
  }

  SpeciesData? get _selectedSpecies {
    for (final item in _species) {
      if (item.id == _selectedSpeciesId) return item;
    }
    return null;
  }

  Future<void> _addSpecies() async {
    final draft = await showDialog<_SpeciesDraft>(
      context: context,
      builder: (context) => const _SpeciesFormDialog(),
    );
    if (draft == null || !mounted) return;

    setState(() => _isCreatingSpecies = true);
    try {
      final id = await _speciesRepository.createCustomSpecies(
        workspaceId: widget.workspaceId,
        commonName: draft.commonName,
        scientificName: draft.scientificName,
        categoryKey: draft.categoryKey,
      );
      await _loadSpecies(selectId: id);
    } catch (error) {
      _showMessage('Spesies belum dapat ditambahkan: $error');
    } finally {
      if (mounted) setState(() => _isCreatingSpecies = false);
    }
  }

  Future<void> _addAttributeDefinition() async {
    final species = _selectedSpecies;
    if (species == null || species.origin != 'custom') return;

    final draft = await showDialog<_AttributeDraft>(
      context: context,
      builder: (context) => const _AttributeFormDialog(),
    );
    if (draft == null || !mounted) return;

    setState(() => _isCreatingAttribute = true);
    try {
      await _speciesRepository.createAttributeDefinition(
        workspaceId: widget.workspaceId,
        speciesId: species.id,
        label: draft.label,
        valueType: draft.valueType,
        appliesTo: draft.appliesTo,
        unitCode: draft.unitCode,
        options: draft.options,
        isRequired: draft.isRequired,
      );
      await _loadAttributeDefinitions();
    } catch (error) {
      _showMessage('Atribut belum dapat ditambahkan: $error');
    } finally {
      if (mounted) setState(() => _isCreatingAttribute = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  Future<DateTime?> _pickDate({
    DateTime? initialDate,
    DateTime? firstDate,
  }) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? _dateOnly(now),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: DateTime(now.year + 30),
    );
  }

  Future<void> _pickBirthDate() async {
    final picked = await _pickDate(
      initialDate: _birthDate,
      firstDate: DateTime(1900),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _birthDate = _dateOnly(picked);
      _birthDatePrecision ??= 'exact';
    });
  }

  Future<void> _pickAcquiredAt() async {
    final picked = await _pickDate(
      initialDate: _acquiredAt,
      firstDate: DateTime(1900),
    );
    if (picked == null || !mounted) return;
    setState(() => _acquiredAt = _dateOnly(picked));
  }

  Future<void> _pickCountObservedAt() async {
    final picked = await _pickDate(
      initialDate: _countObservedAt,
      firstDate: DateTime(1900),
    );
    if (picked == null || !mounted) return;
    setState(() => _countObservedAt = _dateOnly(picked));
  }

  Future<void> _pickAttributeDate(
    SpeciesAttributeDefinition definition,
  ) async {
    final current = _attributeValues[definition.id];
    final picked = await _pickDate(
      initialDate: current is DateTime ? current : null,
      firstDate: DateTime(1900),
    );
    if (picked == null || !mounted) return;
    setState(() => _attributeValues[definition.id] = _dateOnly(picked));
  }

  Map<String, Object?>? _collectAttributeValues() {
    final result = <String, Object?>{};

    for (final definition in _definitions) {
      final id = definition.id;
      Object? value = _attributeValues[id];
      if (definition.valueType == 'boolean' &&
          !_touchedAttributeIds.contains(id)) {
        value = null;
      }

      if (definition.valueType == 'integer' ||
          definition.valueType == 'decimal' ||
          definition.valueType == 'measurement') {
        final raw = _numericInputs[id]?.trim() ?? '';
        if (raw.isNotEmpty) {
          value = definition.valueType == 'integer'
              ? int.tryParse(raw)
              : double.tryParse(raw.replaceAll(',', '.'));
          if (value == null) {
            _showMessage(
              'Nilai "${definition.label}" tidak sesuai dengan tipe angkanya.',
            );
            return null;
          }
        } else {
          value = null;
        }
      }

      final isEmpty = value == null ||
          (value is String && value.trim().isEmpty) ||
          (value is List && value.isEmpty);
      if (definition.isRequired && isEmpty) {
        _showMessage('Atribut "${definition.label}" wajib diisi.');
        return null;
      }
      if (!isEmpty) result[id] = value;
    }

    return result;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final attributes = _collectAttributeValues();
    if (attributes == null) return;

    final countText = _countController.text.trim();
    final reportedCount =
        _isGroup && _memberTrackingMode == 'estimated' && countText.isNotEmpty
            ? int.tryParse(countText)
            : null;
    if (_isGroup &&
        _memberTrackingMode == 'estimated' &&
        countText.isNotEmpty &&
        reportedCount == null) {
      _showMessage('Jumlah anggota harus berupa bilangan bulat.');
      return;
    }
    if (reportedCount != null && _countObservedAt == null) {
      _showMessage('Tanggal pengamatan diperlukan untuk jumlah perkiraan.');
      return;
    }
    if (!_isGroup && _birthDate != null && _birthDatePrecision == null) {
      _showMessage('Pilih presisi tanggal lahir.');
      return;
    }

    Navigator.of(context).pop(
      AnimalProfileDraft(
        name: _nameController.text.trim(),
        isGroup: _isGroup,
        speciesId: _selectedSpeciesId,
        notes: _notesController.text,
        sexCode: _sexController.text,
        birthDate: _isGroup ? null : _birthDate,
        birthDatePrecision: _isGroup
            ? null
            : (_birthDate == null ? 'unknown' : _birthDatePrecision),
        acquiredAt: _isGroup ? null : _acquiredAt,
        lifeStageCode: _isGroup ? null : _lifeStageController.text,
        groupPurpose: _isGroup ? _groupPurposeController.text : null,
        memberTrackingMode:
            _isGroup ? _memberTrackingMode : 'not_tracked',
        reportedCount: reportedCount,
        countObservedAt: reportedCount == null ? null : _countObservedAt,
        countNote: _isGroup ? _countNoteController.text : null,
        attributeValues: attributes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final width = (MediaQuery.sizeOf(context).width - 48).clamp(260.0, 520.0);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      title: Text(widget.initialDetail == null ? 'Tambah profil hewan' : 'Edit profil hewan'),
      content: SizedBox(
        width: width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jenis profil', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 9),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('Individu'),
                      icon: Icon(Icons.pets_outlined),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('Kelompok'),
                      icon: Icon(Icons.groups_outlined),
                    ),
                  ],
                  selected: {_isGroup},
                  showSelectedIcon: false,
                  onSelectionChanged: (selection) async {
                    setState(() {
                      _isGroup = selection.first;
                      _definitions = [];
                      _attributeValues.clear();
                      _numericInputs.clear();
                    });
                    await _loadAttributeDefinitions();
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  key: const Key('animal-name-field'),
                  controller: _nameController,
                  autofocus: true,
                  maxLength: 160,
                  decoration: const InputDecoration(
                    labelText: 'Nama hewan / kelompok',
                    hintText: 'Contoh: Milo atau Koloni ikan guppy',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                _buildSpeciesPicker(),
                const SizedBox(height: 12),
                if (_isGroup) ..._buildGroupFields() else ..._buildIndividualFields(),
                const SizedBox(height: 12),
                _buildAttributeSection(),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (opsional)',
                    hintText: 'Informasi tambahan yang ingin disimpan',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Data yang belum diketahui boleh dibiarkan kosong. Nilai kosong tidak akan diubah menjadi nol.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.save_outlined),
          label: Text(widget.initialDetail == null ? 'Simpan lokal' : 'Simpan perubahan'),
        ),
      ],
    );
  }

  Widget _buildSpeciesPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          key: ValueKey(_selectedSpeciesId),
          initialValue: _selectedSpeciesId ?? _noSpecies,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Spesies',
            border: OutlineInputBorder(),
          ),
          items: [
            const DropdownMenuItem(
              value: _noSpecies,
              child: Text('Belum diketahui / belum dipilih'),
            ),
            for (final species in _species)
              DropdownMenuItem(
                value: species.id,
                child: Text(
                  species.scientificName == null
                      ? species.commonName
                      : '${species.commonName} (${species.scientificName})',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: _speciesLoading ? null : _selectSpecies,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                _speciesLoading
                    ? 'Memuat daftar spesies...'
                    : _species.isEmpty
                        ? 'Belum ada spesies. Anda dapat menambahkan spesies khusus.'
                        : 'Spesies boleh dikosongkan jika belum teridentifikasi.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            TextButton.icon(
              onPressed: _speciesLoading || _isCreatingSpecies ? null : _addSpecies,
              icon: const Icon(Icons.add, size: 18),
              label: Text(_isCreatingSpecies ? 'Menyimpan...' : 'Tambah spesies'),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildIndividualFields() {
    return [
      Text(
        'Detail individu (opsional)',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _sexController,
        decoration: const InputDecoration(
          labelText: 'Jenis kelamin / sex code',
          hintText: 'Gunakan istilah yang sesuai dengan spesies',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 10),
      _DateInputTile(
        label: 'Tanggal lahir',
        value: _birthDate,
        onTap: _pickBirthDate,
        onClear: _birthDate == null
            ? null
            : () => setState(() {
                  _birthDate = null;
                  _birthDatePrecision = 'unknown';
                }),
      ),
      if (_birthDate != null) ...[
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _birthDatePrecision,
          decoration: const InputDecoration(
            labelText: 'Presisi tanggal lahir',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'exact', child: Text('Tanggal tepat')),
            DropdownMenuItem(value: 'estimated', child: Text('Perkiraan')),
          ],
          onChanged: (value) => setState(() => _birthDatePrecision = value),
        ),
      ],
      const SizedBox(height: 10),
      _DateInputTile(
        label: 'Tanggal diperoleh (opsional)',
        value: _acquiredAt,
        onTap: _pickAcquiredAt,
        onClear: _acquiredAt == null
            ? null
            : () => setState(() => _acquiredAt = null),
      ),
      const SizedBox(height: 10),
      TextFormField(
        controller: _lifeStageController,
        decoration: const InputDecoration(
          labelText: 'Tahap hidup (opsional)',
          hintText: 'Contoh sesuai istilah spesies',
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }

  List<Widget> _buildGroupFields() {
    return [
      Text(
        'Detail kelompok',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _groupPurposeController,
        decoration: const InputDecoration(
          labelText: 'Tujuan / jenis kelompok (opsional)',
          hintText: 'Contoh: pembesaran, indukan, koloni',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        initialValue: _memberTrackingMode,
        decoration: const InputDecoration(
          labelText: 'Pencatatan jumlah anggota',
          border: OutlineInputBorder(),
        ),
        items: const [
          DropdownMenuItem(
            value: 'not_tracked',
            child: Text('Belum dicatat'),
          ),
          DropdownMenuItem(
            value: 'estimated',
            child: Text('Jumlah perkiraan'),
          ),
        ],
        onChanged: (value) {
          if (value == null) return;
          setState(() {
            _memberTrackingMode = value;
            if (value == 'not_tracked') {
              _countController.clear();
              _countObservedAt = null;
              _countNoteController.clear();
            }
          });
        },
      ),
      if (_memberTrackingMode == 'estimated') ...[
        const SizedBox(height: 10),
        TextFormField(
          controller: _countController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Jumlah perkiraan (opsional)',
            hintText: 'Isi hanya jika sudah diamati',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        _DateInputTile(
          label: 'Tanggal pengamatan jumlah',
          value: _countObservedAt,
          onTap: _pickCountObservedAt,
          onClear: _countObservedAt == null
              ? null
              : () => setState(() => _countObservedAt = null),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _countNoteController,
          decoration: const InputDecoration(
            labelText: 'Catatan jumlah (opsional)',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ];
  }

  Widget _buildAttributeSection() {
    final species = _selectedSpecies;
    final canCreate = species != null && species.origin == 'custom';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Atribut khusus spesies',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              if (canCreate)
                TextButton.icon(
                  onPressed: _isCreatingAttribute ? null : _addAttributeDefinition,
                  icon: const Icon(Icons.add, size: 17),
                  label: Text(_isCreatingAttribute ? 'Menyimpan...' : 'Tambah'),
                ),
            ],
          ),
          if (species == null)
            Text(
              'Pilih spesies untuk melihat atributnya. Profil tetap dapat disimpan tanpa klasifikasi.',
              style: Theme.of(context).textTheme.bodySmall,
            )
          else if (_attributesLoading)
            const LinearProgressIndicator()
          else if (_definitions.isEmpty)
            Text(
              canCreate
                  ? 'Belum ada atribut untuk spesies khusus ini. Tambahkan atribut yang memang relevan.'
                  : 'Belum ada atribut terdefinisi untuk spesies ini.',
              style: Theme.of(context).textTheme.bodySmall,
            )
          else ...[
            for (final definition in _definitions) ...[
              const SizedBox(height: 8),
              _buildAttributeField(definition),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildAttributeField(SpeciesAttributeDefinition definition) {
    final id = definition.id;
    final label = definition.isRequired
        ? '${definition.label} *'
        : definition.label;

    switch (definition.valueType) {
      case 'text':
        return TextFormField(
          key: ValueKey('attribute-$id'),
          initialValue: _attributeValues[id] as String? ?? '',
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            _attributeValues[id] = value;
          },
        );
      case 'integer':
      case 'decimal':
      case 'measurement':
        return TextFormField(
          key: ValueKey('attribute-$id'),
          initialValue: _numericInputs[id] ?? '',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: label,
            suffixText: definition.unitCode,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) => _numericInputs[id] = value,
        );
      case 'boolean':
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(label),
          value: _attributeValues[id] as bool? ?? false,
          onChanged: (value) => setState(() {
            _attributeValues[id] = value;
            _touchedAttributeIds.add(id);
          }),
        );
      case 'date':
        final date = _attributeValues[id] as DateTime?;
        return _DateInputTile(
          label: label,
          value: date,
          onTap: () => _pickAttributeDate(definition),
          onClear: date == null
              ? null
              : () => setState(() => _attributeValues.remove(id)),
        );
      case 'single_choice':
        final options = _readOptions(definition);
        final selected = _attributeValues[id] as String?;
        return DropdownButtonFormField<String>(
          key: ValueKey('attribute-$id'),
          initialValue: options.contains(selected) ? selected : null,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          items: [
            for (final option in options)
              DropdownMenuItem(value: option, child: Text(option)),
          ],
          onChanged: (value) {
            setState(() {
              if (value == null) {
                _attributeValues.remove(id);
              } else {
                _attributeValues[id] = value;
              }
            });
          },
        );
      case 'multiple_choice':
        final options = _readOptions(definition);
        final selected = (_attributeValues[id] as List?)?.cast<String>() ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelLarge),
            for (final option in options)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(option),
                value: selected.contains(option),
                onChanged: (checked) {
                  setState(() {
                    final next = selected.toSet();
                    if (checked == true) {
                      next.add(option);
                    } else {
                      next.remove(option);
                    }
                    _attributeValues[id] = next.toList(growable: false);
                  });
                },
              ),
          ],
        );
      default:
        return Text(
          'Tipe atribut "${definition.valueType}" belum didukung oleh formulir.',
          style: Theme.of(context).textTheme.bodySmall,
        );
    }
  }

  List<String> _readOptions(SpeciesAttributeDefinition definition) {
    final source = definition.optionsJson;
    if (source == null || source.isEmpty) return const [];
    try {
      final decoded = jsonDecode(source);
      if (decoded is List && decoded.every((item) => item is String)) {
        return decoded.cast<String>();
      }
    } catch (_) {
      // The repository validates the same configuration before saving.
    }
    return const [];
  }
}

class _DateInputTile extends StatelessWidget {
  const _DateInputTile({
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  String _format(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: onClear == null
            ? null
            : IconButton(
                tooltip: 'Hapus tanggal',
                onPressed: onClear,
                icon: const Icon(Icons.close_rounded),
              ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 18),
            const SizedBox(width: 10),
            Text(value == null ? 'Pilih tanggal' : _format(value!)),
          ],
        ),
      ),
    );
  }
}

class _SpeciesDraft {
  const _SpeciesDraft({
    required this.commonName,
    required this.categoryKey,
    this.scientificName,
  });

  final String commonName;
  final String categoryKey;
  final String? scientificName;
}

class _SpeciesFormDialog extends StatefulWidget {
  const _SpeciesFormDialog();

  @override
  State<_SpeciesFormDialog> createState() => _SpeciesFormDialogState();
}

class _SpeciesFormDialogState extends State<_SpeciesFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _commonName = TextEditingController();
  final _scientificName = TextEditingController();
  String _category = 'mammal';

  @override
  void dispose() {
    _commonName.dispose();
    _scientificName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah spesies khusus'),
      content: SizedBox(
        width: 390,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _commonName,
                  autofocus: true,
                  maxLength: 160,
                  decoration: const InputDecoration(
                    labelText: 'Nama umum / nama lokal',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama spesies wajib diisi.'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _scientificName,
                  decoration: const InputDecoration(
                    labelText: 'Nama ilmiah (opsional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'mammal', child: Text('Mamalia')),
                    DropdownMenuItem(value: 'bird', child: Text('Burung')),
                    DropdownMenuItem(value: 'aquatic', child: Text('Akuatik')),
                    DropdownMenuItem(value: 'reptile', child: Text('Reptil')),
                    DropdownMenuItem(value: 'amphibian', child: Text('Amfibi')),
                    DropdownMenuItem(
                      value: 'invertebrate',
                      child: Text('Invertebrata'),
                    ),
                    DropdownMenuItem(
                      value: 'livestock',
                      child: Text('Ternak / unggas'),
                    ),
                    DropdownMenuItem(value: 'other', child: Text('Lainnya')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Spesies ini disimpan khusus pada workspace aktif, bukan sebagai data katalog global.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () {
            if (!(_formKey.currentState?.validate() ?? false)) return;
            Navigator.of(context).pop(
              _SpeciesDraft(
                commonName: _commonName.text.trim(),
                scientificName: _scientificName.text.trim(),
                categoryKey: _category,
              ),
            );
          },
          child: const Text('Simpan spesies'),
        ),
      ],
    );
  }
}

class _AttributeDraft {
  const _AttributeDraft({
    required this.label,
    required this.valueType,
    required this.appliesTo,
    required this.isRequired,
    required this.options,
    this.unitCode,
  });

  final String label;
  final String valueType;
  final String appliesTo;
  final bool isRequired;
  final List<String> options;
  final String? unitCode;
}

class _AttributeFormDialog extends StatefulWidget {
  const _AttributeFormDialog();

  @override
  State<_AttributeFormDialog> createState() => _AttributeFormDialogState();
}

class _AttributeFormDialogState extends State<_AttributeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _unitController = TextEditingController();
  final _optionsController = TextEditingController();
  String _valueType = 'text';
  String _appliesTo = 'both';
  bool _required = false;

  @override
  void dispose() {
    _labelController.dispose();
    _unitController.dispose();
    _optionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isChoice =
        _valueType == 'single_choice' || _valueType == 'multiple_choice';
    final isMeasurement = _valueType == 'measurement';

    return AlertDialog(
      title: const Text('Tambah atribut spesies'),
      content: SizedBox(
        width: 390,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _labelController,
                  autofocus: true,
                  maxLength: 120,
                  decoration: const InputDecoration(
                    labelText: 'Nama atribut',
                    hintText: 'Contoh: Pola warna',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama atribut wajib diisi.'
                      : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _valueType,
                  decoration: const InputDecoration(
                    labelText: 'Jenis data',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'text', child: Text('Teks')),
                    DropdownMenuItem(
                      value: 'integer',
                      child: Text('Bilangan bulat'),
                    ),
                    DropdownMenuItem(value: 'decimal', child: Text('Desimal')),
                    DropdownMenuItem(value: 'boolean', child: Text('Ya / tidak')),
                    DropdownMenuItem(value: 'date', child: Text('Tanggal')),
                    DropdownMenuItem(
                      value: 'single_choice',
                      child: Text('Satu pilihan'),
                    ),
                    DropdownMenuItem(
                      value: 'multiple_choice',
                      child: Text('Beberapa pilihan'),
                    ),
                    DropdownMenuItem(
                      value: 'measurement',
                      child: Text('Pengukuran bersatuan'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _valueType = value);
                  },
                ),
                if (isMeasurement) ...[
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _unitController,
                    decoration: const InputDecoration(
                      labelText: 'Kode satuan',
                      hintText: 'Contoh: cm, g, ml',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        isMeasurement && (value == null || value.trim().isEmpty)
                            ? 'Satuan wajib diisi.'
                            : null,
                  ),
                ],
                if (isChoice) ...[
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _optionsController,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Daftar pilihan',
                      hintText: 'Pisahkan dengan koma atau baris baru',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (!isChoice) return null;
                      final options = (value ?? '')
                          .split(RegExp(r'[,;\n]'))
                          .map((item) => item.trim())
                          .where((item) => item.isNotEmpty)
                          .toSet();
                      return options.isEmpty
                          ? 'Masukkan minimal satu pilihan.'
                          : null;
                    },
                  ),
                ],
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _appliesTo,
                  decoration: const InputDecoration(
                    labelText: 'Berlaku untuk',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'both', child: Text('Individu dan kelompok')),
                    DropdownMenuItem(value: 'individual', child: Text('Individu saja')),
                    DropdownMenuItem(value: 'group', child: Text('Kelompok saja')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _appliesTo = value);
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Wajib diisi'),
                  value: _required,
                  onChanged: (value) =>
                      setState(() => _required = value ?? false),
                ),
                Text(
                  'Atribut ini menjadi definisi khusus spesies pada workspace ini. Atribut bersifat deskriptif, bukan pengganti catatan pengukuran berkala.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () {
            if (!(_formKey.currentState?.validate() ?? false)) return;
            final options = _optionsController.text
                .split(RegExp(r'[,;\n]'))
                .map((item) => item.trim())
                .where((item) => item.isNotEmpty)
                .toSet()
                .toList(growable: false);
            Navigator.of(context).pop(
              _AttributeDraft(
                label: _labelController.text.trim(),
                valueType: _valueType,
                appliesTo: _appliesTo,
                isRequired: _required,
                unitCode:
                    _valueType == 'measurement' ? _unitController.text.trim() : null,
                options: options,
              ),
            );
          },
          child: const Text('Simpan atribut'),
        ),
      ],
    );
  }
}
