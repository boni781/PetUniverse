import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../species/data/species_repository.dart';
import '../data/animal_repository.dart';
import 'animal_profile_form_dialog.dart';

class AnimalListPage extends StatefulWidget {
  const AnimalListPage({
    required this.database,
    required this.workspaceId,
    super.key,
  });

  final AppDatabase database;
  final String workspaceId;

  @override
  State<AnimalListPage> createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  late final AnimalRepository _repository;
  late final SpeciesRepository _speciesRepository;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _repository = AnimalRepository(widget.database);
    _speciesRepository = SpeciesRepository(widget.database);
  }

  Future<void> _addAnimal() async {
    final draft = await showDialog<AnimalProfileDraft>(
      context: context,
      builder: (context) => AnimalProfileFormDialog(
        database: widget.database,
        workspaceId: widget.workspaceId,
      ),
    );

    if (draft == null || !mounted) return;

    setState(() => _isSaving = true);
    try {
      if (draft.isGroup) {
        await _repository.createGroup(
          workspaceId: widget.workspaceId,
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
        await _repository.createIndividual(
          workspaceId: widget.workspaceId,
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profil tersimpan di perangkat. Sinkronisasi cloud belum diaktifkan.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan profil: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
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
                'MANAJEMEN HEWAN',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
              ),
              const SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Pengelolaan hewan',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _isSaving ? null : _addAnimal,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Tambah hewan'),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                'Profil individu dan kelompok tersimpan pada workspace yang sedang aktif.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 22),
              StreamBuilder<List<AnimalProfile>>(
                stream: _repository.watchProfiles(widget.workspaceId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _MessageCard(
                      icon: Icons.error_outline_rounded,
                      title: 'Data belum dapat dibaca',
                      message:
                          'Periksa koneksi database lokal lalu coba kembali. ${snapshot.error}',
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final profiles = snapshot.data!;
                  if (profiles.isEmpty) {
                    return _MessageCard(
                      icon: Icons.pets_rounded,
                      title: 'Belum ada profil hewan',
                      message:
                          'Tambahkan profil individu atau kelompok. Pilih spesies jika sudah diketahui, atau simpan profil tanpa klasifikasi terlebih dahulu. Data akan langsung tersimpan di perangkat.',
                      action: OutlinedButton.icon(
                        onPressed: _isSaving ? null : _addAnimal,
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Buat profil pertama'),
                      ),
                    );
                  }

                  return StreamBuilder<List<SpeciesData>>(
                    stream: _speciesRepository
                        .watchAvailableSpecies(widget.workspaceId),
                    builder: (context, speciesSnapshot) {
                      final speciesById = {
                        for (final item in speciesSnapshot.data ?? [])
                          item.id: item.commonName,
                      };

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Daftar profil',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(width: 9),
                              _CountBadge(count: profiles.length),
                            ],
                          ),
                          const SizedBox(height: 13),
                          for (final profile in profiles) ...[
                            _AnimalCard(
                              profile: profile,
                              speciesName: profile.speciesId == null
                                  ? null
                                  : speciesById[profile.speciesId],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ],
                      );
                    },
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
                    Icon(Icons.wifi_off_rounded, color: colors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Mode lokal aktif. Setiap profil, detail individu/kelompok, atribut spesies, dan antrean sinkronisasi disimpan dalam satu transaksi database. Pengiriman ke cloud belum diaktifkan.',
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

class _AnimalCard extends StatelessWidget {
  const _AnimalCard({
    required this.profile,
    required this.speciesName,
  });

  final AnimalProfile profile;
  final String? speciesName;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isGroup = profile.recordKind == 'group';
    final dateLabel = profile.createdAt.toLocal().toString().split('.').first;
    final classification = speciesName ?? 'Belum diklasifikasikan';

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(
            isGroup ? Icons.groups_rounded : Icons.pets_rounded,
            color: colors.onPrimaryContainer,
          ),
        ),
        title: Text(
          profile.displayName,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${isGroup ? 'Kelompok' : 'Individu'} • $classification • $dateLabel',
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

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
        '$count',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.onSecondaryContainer,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
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
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.7)),
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
            constraints: const BoxConstraints(maxWidth: 540),
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
