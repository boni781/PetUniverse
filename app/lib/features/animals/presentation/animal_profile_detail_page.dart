import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../data/animal_repository.dart';
import 'animal_profile_form_dialog.dart';

class AnimalProfileDetailPage extends StatefulWidget {
  const AnimalProfileDetailPage({
    required this.database,
    required this.workspaceId,
    required this.profileId,
    super.key,
  });

  final AppDatabase database;
  final String workspaceId;
  final String profileId;

  @override
  State<AnimalProfileDetailPage> createState() =>
      _AnimalProfileDetailPageState();
}

class _AnimalProfileDetailPageState extends State<AnimalProfileDetailPage> {
  late final AnimalRepository _repository;
  late Future<AnimalProfileDetail?> _detailFuture;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _repository = AnimalRepository(widget.database);
    _detailFuture = _loadDetail();
  }

  Future<AnimalProfileDetail?> _loadDetail() {
    return _repository.getProfileDetail(
      workspaceId: widget.workspaceId,
      profileId: widget.profileId,
    );
  }

  Future<void> _editProfile(AnimalProfileDetail detail) async {
    final draft = await showDialog<AnimalProfileDraft>(
      context: context,
      builder: (context) => AnimalProfileFormDialog(
        database: widget.database,
        workspaceId: widget.workspaceId,
        initialDetail: detail,
      ),
    );
    if (draft == null || !mounted) return;

    setState(() => _isSaving = true);
    try {
      if (draft.isGroup) {
        await _repository.updateGroup(
          workspaceId: widget.workspaceId,
          profileId: widget.profileId,
          displayName: draft.name,
          speciesId: draft.speciesId,
          notes: draft.notes,
          groupPurpose: draft.groupPurpose,
          memberTrackingMode: draft.memberTrackingMode,
          reportedCount: draft.reportedCount,
          countObservedAt: draft.countObservedAt,
          countNote: draft.countNote,
          attributeValues: draft.attributeValues,
        );
      } else {
        await _repository.updateIndividual(
          workspaceId: widget.workspaceId,
          profileId: widget.profileId,
          displayName: draft.name,
          speciesId: draft.speciesId,
          notes: draft.notes,
          sexCode: draft.sexCode,
          birthDate: draft.birthDate,
          birthDatePrecision: draft.birthDatePrecision,
          acquiredAt: draft.acquiredAt,
          lifeStageCode: draft.lifeStageCode,
          attributeValues: draft.attributeValues,
        );
      }

      if (!mounted) return;
      setState(() => _detailFuture = _loadDetail());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Perubahan profil tersimpan di perangkat. Sinkronisasi cloud belum diaktifkan.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui profil: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String _dateLabel(DateTime? value) {
    if (value == null) return 'Belum diisi';
    final local = value.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    return '$day/$month/${local.year}';
  }

  String _attributeLabel(AnimalAttributeSnapshot attribute) {
    final value = attribute.value;
    if (value == null) return 'Belum diisi';
    if (value is DateTime) return _dateLabel(value);
    if (value is bool) return value ? 'Ya' : 'Tidak';
    if (value is List) return value.join(', ');
    if (attribute.unitCode != null && value is num) {
      return '$value ${attribute.unitCode}';
    }
    return value.toString();
  }

  Widget _section({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    IconData? icon,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: colors.primary, size: 20),
                  const SizedBox(width: 9),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _valueRow(BuildContext context, String label, String value) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String _trackingModeLabel(String value) {
    return switch (value) {
      'tracked' => 'Dicatat melalui anggota satu per satu',
      'estimated' => 'Jumlah perkiraan',
      _ => 'Belum dicatat',
    };
  }

  Widget _buildDetail(BuildContext context, AnimalProfileDetail detail) {
    final profile = detail.profile;
    final isGroup = profile.recordKind == 'group';
    final colors = Theme.of(context).colorScheme;
    final typeLabel = isGroup ? 'Kelompok' : 'Individu';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: colors.primaryContainer,
                        child: Icon(
                          isGroup ? Icons.groups_rounded : Icons.pets_rounded,
                          size: 29,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              detail.species?.commonName ??
                                  'Belum diklasifikasikan',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Chip(
                                  avatar: Icon(
                                    isGroup ? Icons.groups_outlined : Icons.pets_outlined,
                                    size: 16,
                                  ),
                                  label: Text(typeLabel),
                                  visualDensity: VisualDensity.compact,
                                ),
                                Chip(
                                  label: Text(
                                    profile.profileStatus == 'active'
                                        ? 'Aktif'
                                        : profile.profileStatus,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _section(
                context: context,
                title: 'Informasi umum',
                icon: Icons.badge_outlined,
                children: [
                  _valueRow(context, 'Nama profil', profile.displayName),
                  _valueRow(context, 'Jenis profil', typeLabel),
                  _valueRow(
                    context,
                    'Nama umum spesies',
                    detail.species?.commonName ?? 'Belum diketahui',
                  ),
                  if (detail.species?.scientificName != null)
                    _valueRow(
                      context,
                      'Nama ilmiah',
                      detail.species!.scientificName!,
                    ),
                  if (detail.species != null)
                    _valueRow(
                      context,
                      'Kategori spesies',
                      detail.species!.categoryKey,
                    ),
                  _valueRow(context, 'Dibuat', _dateLabel(profile.createdAt)),
                  _valueRow(context, 'Terakhir diperbarui', _dateLabel(profile.updatedAt)),
                ],
              ),
              if (!isGroup && detail.individualDetails != null)
                _section(
                  context: context,
                  title: 'Detail individu',
                  icon: Icons.person_outline_rounded,
                  children: [
                    _valueRow(
                      context,
                      'Jenis kelamin',
                      detail.individualDetails!.sexCode ?? 'Belum diketahui',
                    ),
                    _valueRow(
                      context,
                      'Tanggal lahir',
                      _dateLabel(detail.individualDetails!.birthDate),
                    ),
                    _valueRow(
                      context,
                      'Presisi tanggal lahir',
                      switch (detail.individualDetails!.birthDatePrecision) {
                        'exact' => 'Tanggal tepat',
                        'estimated' => 'Perkiraan',
                        'unknown' => 'Tidak diketahui',
                        _ => 'Belum diisi',
                      },
                    ),
                    _valueRow(
                      context,
                      'Tanggal diperoleh',
                      _dateLabel(detail.individualDetails!.acquiredAt),
                    ),
                    _valueRow(
                      context,
                      'Tahap hidup',
                      detail.individualDetails!.lifeStageCode ?? 'Belum diketahui',
                    ),
                  ],
                ),
              if (isGroup && detail.groupDetails != null)
                _section(
                  context: context,
                  title: 'Detail kelompok',
                  icon: Icons.groups_outlined,
                  children: [
                    _valueRow(
                      context,
                      'Tujuan kelompok',
                      detail.groupDetails!.groupPurpose ?? 'Belum diisi',
                    ),
                    _valueRow(
                      context,
                      'Pencatatan anggota',
                      _trackingModeLabel(detail.groupDetails!.memberTrackingMode),
                    ),
                    _valueRow(
                      context,
                      'Jumlah anggota',
                      detail.groupDetails!.reportedCount == null
                          ? 'Belum diketahui'
                          : detail.groupDetails!.memberTrackingMode == 'estimated'
                              ? 'Perkiraan: ${detail.groupDetails!.reportedCount}'
                              : detail.groupDetails!.reportedCount.toString(),
                    ),
                    _valueRow(
                      context,
                      'Tanggal pengamatan',
                      _dateLabel(detail.groupDetails!.countObservedAt),
                    ),
                    _valueRow(
                      context,
                      'Catatan jumlah',
                      detail.groupDetails!.countNote ?? 'Belum diisi',
                    ),
                  ],
                ),
              if (detail.attributes.isNotEmpty)
                _section(
                  context: context,
                  title: 'Atribut spesies',
                  icon: Icons.tune_rounded,
                  children: [
                    for (final attribute in detail.attributes)
                      _valueRow(
                        context,
                        attribute.definition.label,
                        _attributeLabel(attribute),
                      ),
                  ],
                ),
              _section(
                context: context,
                title: 'Catatan',
                icon: Icons.notes_rounded,
                children: [
                  Text(
                    profile.notes == null || profile.notes!.trim().isEmpty
                        ? 'Belum ada catatan.'
                        : profile.notes!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.cloud_off_outlined, color: colors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Perubahan disimpan pada perangkat. Sinkronisasi cloud belum diaktifkan.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail profil hewan'),
        actions: [
          FutureBuilder<AnimalProfileDetail?>(
            future: _detailFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Edit profil',
                onPressed: _isSaving ? null : () => _editProfile(snapshot.data!),
                icon: const Icon(Icons.edit_outlined),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<AnimalProfileDetail?>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Detail profil gagal dibaca: ${snapshot.error}'),
              ),
            );
          }
          final detail = snapshot.data;
          if (detail == null) {
            return const Center(
              child: Text('Profil tidak ditemukan pada workspace ini.'),
            );
          }
          return _buildDetail(context, detail);
        },
      ),
    );
  }
}
