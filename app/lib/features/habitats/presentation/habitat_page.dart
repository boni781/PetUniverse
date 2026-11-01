import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../animals/data/animal_repository.dart';
import '../data/habitat_repository.dart';

class HabitatPage extends StatefulWidget {
  const HabitatPage({
    required this.database,
    required this.workspaceId,
    super.key,
  });

  final AppDatabase database;
  final String workspaceId;

  @override
  State<HabitatPage> createState() => _HabitatPageState();
}

class _HabitatPageState extends State<HabitatPage> {
  late final HabitatRepository _repository;
  late final AnimalRepository _animalRepository;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _repository = HabitatRepository(widget.database);
    _animalRepository = AnimalRepository(widget.database);
  }

  Future<void> _editHabitat([Habitat? habitat]) async {
    try {
      final habitats = await _repository.watchHabitats(widget.workspaceId).first;
      if (!mounted) return;

      final draft = await showDialog<_HabitatDraft>(
        context: context,
        builder: (context) => _HabitatFormDialog(
          habitats: habitats,
          initialHabitat: habitat,
        ),
      );
      if (draft == null || !mounted) return;

      setState(() => _isSaving = true);
      if (habitat == null) {
        await _repository.createHabitat(
          workspaceId: widget.workspaceId,
          name: draft.name,
          habitatType: draft.habitatType,
          parentHabitatId: draft.parentHabitatId,
          description: draft.description,
          capacityValue: draft.capacityValue,
          capacityUnit: draft.capacityUnit,
        );
      } else {
        await _repository.updateHabitat(
          workspaceId: widget.workspaceId,
          habitatId: habitat.id,
          name: draft.name,
          habitatType: draft.habitatType,
          parentHabitatId: draft.parentHabitatId,
          description: draft.description,
          capacityValue: draft.capacityValue,
          capacityUnit: draft.capacityUnit,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            habitat == null
                ? 'Habitat tersimpan di perangkat.'
                : 'Perubahan habitat tersimpan di perangkat.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan habitat: ' + error.toString())),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _archiveHabitat(Habitat habitat) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arsipkan habitat?'),
        content: Text(
          'Habitat "' + habitat.name + '" tidak akan menerima penempatan baru. '
          'Riwayat yang sudah ada tetap disimpan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Arsipkan'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      await _repository.archiveHabitat(
        workspaceId: widget.workspaceId,
        habitatId: habitat.id,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Habitat berhasil diarsipkan.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Habitat belum dapat diarsipkan: ' + error.toString())),
      );
    }
  }

  Future<void> _manageAssignments(Habitat habitat) async {
    try {
      final profiles =
          await _animalRepository.watchProfiles(widget.workspaceId).first;
      if (!mounted) return;

      var historyFuture = _repository.getAssignmentsForHabitat(
        workspaceId: widget.workspaceId,
        habitatId: habitat.id,
      );

      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (sheetContext) => StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(sheetContext).height * 0.78,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Penempatan — ' + habitat.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Daftar hewan yang pernah atau sedang menempati habitat ini.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FilledButton.icon(
                          onPressed: habitat.status != 'active' || profiles.isEmpty
                              ? null
                              : () async {
                                  final draft = await showDialog<_AssignmentDraft>(
                                    context: sheetContext,
                                    builder: (context) => _AssignmentFormDialog(
                                      profiles: profiles,
                                    ),
                                  );
                                  if (draft == null) return;

                                  try {
                                    await _repository.assignProfile(
                                      workspaceId: widget.workspaceId,
                                      profileId: draft.profileId,
                                      habitatId: habitat.id,
                                      assignmentRole: draft.assignmentRole,
                                      validFrom: draft.validFrom,
                                      note: draft.note,
                                    );
                                    setSheetState(() {
                                      historyFuture =
                                          _repository.getAssignmentsForHabitat(
                                        workspaceId: widget.workspaceId,
                                        habitatId: habitat.id,
                                      );
                                    });
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(this.context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Penempatan tersimpan. Riwayat lama tetap tercatat.',
                                        ),
                                      ),
                                    );
                                  } catch (error) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(this.context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Gagal menyimpan penempatan: ' + error.toString(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                          icon: const Icon(Icons.add_location_alt_outlined),
                          label: const Text('Tempatkan hewan'),
                        ),
                      ),
                      if (profiles.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Buat profil hewan terlebih dahulu sebelum membuat penempatan.',
                          ),
                        ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: FutureBuilder<List<HabitatAssignmentEntry>>(
                          future: historyFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Riwayat gagal dibaca: ' + snapshot.error.toString(),
                                ),
                              );
                            }

                            final entries = snapshot.data ?? [];
                            if (entries.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Belum ada hewan yang ditempatkan di habitat ini.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            return ListView.separated(
                              itemCount: entries.length,
                              separatorBuilder: (_, __) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final entry = entries[index];
                                final assignment = entry.assignment;
                                final active = assignment.validTo == null;
                                final profileName =
                                    entry.profile?.displayName ?? 'Profil tidak tersedia';
                                final role = assignment.assignmentRole == 'primary'
                                    ? 'Habitat utama'
                                    : 'Habitat sekunder';
                                final range = _dateLabel(assignment.validFrom) +
                                    (active
                                        ? ' – Sekarang'
                                        : ' – ' + _dateLabel(assignment.validTo!));

                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    child: Icon(
                                      entry.profile?.recordKind == 'group'
                                          ? Icons.groups_outlined
                                          : Icons.pets_outlined,
                                    ),
                                  ),
                                  title: Text(
                                    profileName,
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(
                                    role + ' • ' + range +
                                        (assignment.note == null
                                            ? ''
                                            : '\n' + assignment.note!),
                                  ),
                                  isThreeLine: assignment.note != null,
                                  trailing: active
                                      ? IconButton(
                                          tooltip: 'Akhiri penempatan',
                                          icon: const Icon(Icons.event_busy_outlined),
                                          onPressed: () async {
                                            try {
                                              await _repository.closeAssignment(
                                                workspaceId: widget.workspaceId,
                                                assignmentId: assignment.id,
                                                validTo: DateTime.now(),
                                              );
                                              setSheetState(() {
                                                historyFuture =
                                                    _repository.getAssignmentsForHabitat(
                                                  workspaceId: widget.workspaceId,
                                                  habitatId: habitat.id,
                                                );
                                              });
                                            } catch (error) {
                                              if (!mounted) return;
                                              ScaffoldMessenger.of(this.context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Penempatan belum dapat ditutup: ' +
                                                        error.toString(),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      : const Icon(Icons.history_rounded),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka penempatan: ' + error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LINGKUNGAN DAN LOKASI',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Habitat dan kandang',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _isSaving ? null : () => _editHabitat(),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Tambah habitat'),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                'Atur lokasi pemeliharaan, kapasitas, struktur area, dan riwayat penempatan setiap profil hewan.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<List<Habitat>>(
                stream: _repository.watchHabitats(widget.workspaceId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _HabitatMessage(
                      icon: Icons.error_outline_rounded,
                      title: 'Data habitat belum dapat dibaca',
                      message: snapshot.error.toString(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final habitats = snapshot.data!;
                  if (habitats.isEmpty) {
                    return _HabitatMessage(
                      icon: Icons.house_outlined,
                      title: 'Belum ada habitat',
                      message:
                          'Buat lokasi seperti akuarium, kandang, kolam, aviary, atau area pemeliharaan lainnya. Habitat dapat dibuat bertingkat, misalnya fasilitas → ruangan → kandang.',
                      action: OutlinedButton.icon(
                        onPressed: _isSaving ? null : () => _editHabitat(),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Buat habitat pertama'),
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Daftar habitat',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 9),
                          _HabitatCountBadge(count: habitats.length),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final habitat in habitats) ...[
                        _HabitatCard(
                          habitat: habitat,
                          onManage: () => _manageAssignments(habitat),
                          onEdit: () => _editHabitat(habitat),
                          onArchive: () => _archiveHabitat(habitat),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.outlineVariant.withValues(alpha: 0.65),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.history_rounded, color: colors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Riwayat penempatan tidak dihapus saat hewan dipindahkan. Penempatan lama akan diberi tanggal akhir, lalu penempatan baru disimpan sebagai catatan terpisah. Pengelolaan ini masih berjalan sepenuhnya di perangkat.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.45,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HabitatCard extends StatelessWidget {
  const _HabitatCard({
    required this.habitat,
    required this.onManage,
    required this.onEdit,
    required this.onArchive,
  });

  final Habitat habitat;
  final VoidCallback onManage;
  final VoidCallback onEdit;
  final VoidCallback onArchive;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final archived = habitat.status == 'archived';
    final capacity = habitat.capacityValue == null
        ? 'Kapasitas belum ditentukan'
        : 'Kapasitas ' +
            habitat.capacityValue.toString() +
            ' ' +
            (habitat.capacityUnit ?? '');

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 13, 10, 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: colors.primaryContainer,
              child: Icon(
                _habitatIcon(habitat.habitatType),
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        habitat.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      if (archived)
                        Chip(
                          label: const Text('Diarsipkan'),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: colors.surfaceContainerHighest,
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _habitatTypeLabel(habitat.habitatType) + ' • ' + capacity,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
                  if (habitat.description != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      habitat.description!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 7,
                    children: [
                      OutlinedButton.icon(
                        onPressed: onManage,
                        icon: const Icon(Icons.people_alt_outlined, size: 17),
                        label: const Text('Penempatan'),
                      ),
                      TextButton.icon(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined, size: 17),
                        label: const Text('Edit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Pilihan habitat',
              onSelected: (value) {
                if (value == 'archive') onArchive();
                if (value == 'edit') onEdit();
                if (value == 'assign') onManage();
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'assign',
                  child: ListTile(
                    leading: Icon(Icons.people_alt_outlined),
                    title: Text('Kelola penempatan'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit habitat'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                if (!archived)
                  const PopupMenuItem(
                    value: 'archive',
                    child: ListTile(
                      leading: Icon(Icons.archive_outlined),
                      title: Text('Arsipkan'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HabitatFormDialog extends StatefulWidget {
  const _HabitatFormDialog({
    required this.habitats,
    this.initialHabitat,
  });

  final List<Habitat> habitats;
  final Habitat? initialHabitat;

  @override
  State<_HabitatFormDialog> createState() => _HabitatFormDialogState();
}

class _HabitatFormDialogState extends State<_HabitatFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _capacityController;
  late final TextEditingController _capacityUnitController;
  late String _habitatType;
  String? _parentHabitatId;

  static const _types = [
    'aquarium',
    'pond',
    'cage',
    'aviary',
    'terrarium',
    'enclosure',
    'livestock_housing',
    'other',
  ];

  List<String> get _availableTypes {
    final values = [..._types];
    if (!values.contains(_habitatType)) values.add(_habitatType);
    return values;
  }

  @override
  void initState() {
    super.initState();
    final habitat = widget.initialHabitat;
    _nameController = TextEditingController(text: habitat?.name ?? '');
    _descriptionController =
        TextEditingController(text: habitat?.description ?? '');
    _capacityController = TextEditingController(
      text: habitat?.capacityValue?.toString() ?? '',
    );
    _capacityUnitController =
        TextEditingController(text: habitat?.capacityUnit ?? '');
    _habitatType = habitat?.habitatType ?? 'enclosure';
    _parentHabitatId = habitat?.parentHabitatId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _capacityController.dispose();
    _capacityUnitController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final capacityText = _capacityController.text.trim();
    final capacity = capacityText.isEmpty ? null : double.tryParse(capacityText);
    Navigator.pop(
      context,
      _HabitatDraft(
        name: _nameController.text.trim(),
        habitatType: _habitatType,
        parentHabitatId: _parentHabitatId,
        description: _descriptionController.text.trim(),
        capacityValue: capacity,
        capacityUnit: _capacityUnitController.text.trim().isEmpty
            ? null
            : _capacityUnitController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parentOptions = widget.habitats
        .where((item) => item.id != widget.initialHabitat?.id)
        .where(
          (item) =>
              item.status != 'archived' || item.id == _parentHabitatId,
        )
        .toList();

    return AlertDialog(
      title: Text(
        widget.initialHabitat == null ? 'Tambah habitat' : 'Edit habitat',
      ),
      content: SizedBox(
        width: 440,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Nama habitat *',
                    hintText: 'Contoh: Akuarium utama',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama habitat wajib diisi.';
                    }
                    if (value.trim().length > 160) {
                      return 'Maksimal 160 karakter.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                DropdownButtonFormField<String>(
                  initialValue: _habitatType,
                  decoration: const InputDecoration(
                    labelText: 'Jenis habitat *',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final type in _availableTypes)
                      DropdownMenuItem(
                        value: type,
                        child: Text(_habitatTypeLabel(type)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _habitatType = value);
                  },
                ),
                const SizedBox(height: 13),
                DropdownButtonFormField<String?>(
                  initialValue: _parentHabitatId,
                  decoration: const InputDecoration(
                    labelText: 'Habitat induk (opsional)',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Tidak ada — lokasi utama'),
                    ),
                    for (final parent in parentOptions)
                      DropdownMenuItem<String?>(
                        value: parent.id,
                        child: Text(parent.name),
                      ),
                  ],
                  onChanged: (value) =>
                      setState(() => _parentHabitatId = value),
                ),
                const SizedBox(height: 13),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: 'Kondisi atau keterangan lokasi',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _capacityController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Kapasitas',
                          hintText: 'Opsional',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final text = value?.trim() ?? '';
                          if (text.isEmpty) {
                            if (_capacityUnitController.text.trim().isNotEmpty) {
                              return 'Isi nilai kapasitas.';
                            }
                            return null;
                          }
                          final number = double.tryParse(text);
                          if (number == null ||
                              !number.isFinite ||
                              number <= 0) {
                            return 'Masukkan angka positif.';
                          }
                          if (_capacityUnitController.text.trim().isEmpty) {
                            return 'Satuan wajib diisi.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _capacityUnitController,
                        decoration: const InputDecoration(
                          labelText: 'Satuan',
                          hintText: 'ekor, liter, m³',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (_capacityController.text.trim().isNotEmpty &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Satuan wajib diisi.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Simpan lokal'),
        ),
      ],
    );
  }
}

class _AssignmentFormDialog extends StatefulWidget {
  const _AssignmentFormDialog({required this.profiles});

  final List<AnimalProfile> profiles;

  @override
  State<_AssignmentFormDialog> createState() => _AssignmentFormDialogState();
}

class _AssignmentFormDialogState extends State<_AssignmentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  String? _profileId;
  String _assignmentRole = 'primary';
  DateTime _validFrom = DateTime.now();

  @override
  void initState() {
    super.initState();
    _profileId = widget.profiles.isEmpty ? null : widget.profiles.first.id;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _validFrom,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      helpText: 'Tanggal mulai penempatan',
    );
    if (selected == null || !mounted) return;

    setState(() {
      _validFrom = DateTime(
        selected.year,
        selected.month,
        selected.day,
        _validFrom.hour,
        _validFrom.minute,
        _validFrom.second,
      );
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _profileId == null) return;
    Navigator.pop(
      context,
      _AssignmentDraft(
        profileId: _profileId!,
        assignmentRole: _assignmentRole,
        validFrom: _validFrom,
        note: _noteController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tempatkan hewan'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: _profileId,
                decoration: const InputDecoration(
                  labelText: 'Profil hewan *',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final profile in widget.profiles)
                    DropdownMenuItem(
                      value: profile.id,
                      child: Text(
                        profile.displayName +
                            ' · ' +
                            (profile.recordKind == 'group' ? 'Kelompok' : 'Individu'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (value) => setState(() => _profileId = value),
                validator: (value) =>
                    value == null ? 'Pilih profil hewan.' : null,
              ),
              const SizedBox(height: 13),
              DropdownButtonFormField<String>(
                initialValue: _assignmentRole,
                decoration: const InputDecoration(
                  labelText: 'Peran penempatan',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'primary',
                    child: Text('Habitat utama'),
                  ),
                  DropdownMenuItem(
                    value: 'secondary',
                    child: Text('Habitat sekunder'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _assignmentRole = value);
                  }
                },
              ),
              const SizedBox(height: 13),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: Text('Mulai: ' + _dateLabel(_validFrom)),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteController,
                minLines: 2,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan penempatan',
                  hintText: 'Contoh: dipindahkan untuk masa karantina',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Simpan penempatan'),
        ),
      ],
    );
  }
}

class _HabitatDraft {
  const _HabitatDraft({
    required this.name,
    required this.habitatType,
    required this.parentHabitatId,
    required this.description,
    required this.capacityValue,
    required this.capacityUnit,
  });

  final String name;
  final String habitatType;
  final String? parentHabitatId;
  final String description;
  final double? capacityValue;
  final String? capacityUnit;
}

class _AssignmentDraft {
  const _AssignmentDraft({
    required this.profileId,
    required this.assignmentRole,
    required this.validFrom,
    required this.note,
  });

  final String profileId;
  final String assignmentRole;
  final DateTime validFrom;
  final String note;
}

class _HabitatCountBadge extends StatelessWidget {
  const _HabitatCountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.onSecondaryContainer,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _HabitatMessage extends StatelessWidget {
  const _HabitatMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 29, color: colors.onPrimaryContainer),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
            ),
          ),
          if (action != null) ...[
            const SizedBox(height: 16),
            action!,
          ],
        ],
      ),
    );
  }
}

String _dateLabel(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return day + '/' + month + '/' + local.year.toString();
}

String _habitatTypeLabel(String value) {
  return switch (value) {
    'aquarium' => 'Akuarium',
    'pond' => 'Kolam',
    'cage' => 'Kandang',
    'aviary' => 'Aviary',
    'terrarium' => 'Terrarium',
    'enclosure' => 'Area pemeliharaan',
    'livestock_housing' => 'Kandang ternak',
    _ => 'Lainnya',
  };
}

IconData _habitatIcon(String value) {
  return switch (value) {
    'aquarium' => Icons.water_rounded,
    'pond' => Icons.water_rounded,
    'cage' => Icons.grid_view_rounded,
    'aviary' => Icons.flight_rounded,
    'terrarium' => Icons.eco_outlined,
    'livestock_housing' => Icons.agriculture_outlined,
    _ => Icons.house_rounded,
  };
}
