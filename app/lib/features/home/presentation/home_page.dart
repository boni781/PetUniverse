import 'package:flutter/material.dart';

import '../../../core/workspace/workspace_mode.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.mode,
    required this.onModeChanged,
    required this.onOpenAnimals,
    required this.onOpenSchedule,
    super.key,
  });

  final WorkspaceMode mode;
  final ValueChanged<WorkspaceMode> onModeChanged;
  final VoidCallback onOpenAnimals;
  final VoidCallback onOpenSchedule;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth < 520 ? 18.0 : 28.0;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(padding, 24, padding, 34),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang di PetUniverse 👋',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.6,
                        ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    mode.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                          height: 1.45,
                        ),
                  ),
                  const SizedBox(height: 22),
                  _WorkspaceCard(mode: mode, onChanged: onModeChanged),
                  const SizedBox(height: 26),
                  Text(
                    'Ringkasan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 13),
                  LayoutBuilder(
                    builder: (context, box) {
                      final columns = box.maxWidth >= 1050
                          ? 4
                          : box.maxWidth >= 560
                              ? 2
                              : 1;
                      const gap = 12.0;
                      final width =
                          (box.maxWidth - gap * (columns - 1)) / columns;
                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          SizedBox(
                            width: width,
                            child: const _MetricCard(
                              icon: Icons.pets_rounded,
                              label: 'Total hewan',
                              value: '0',
                              detail: 'Belum ada profil',
                              tint: Color(0xFFDDF5EF),
                              iconColor: Color(0xFF176D5B),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: const _MetricCard(
                              icon: Icons.calendar_month_rounded,
                              label: 'Jadwal aktif',
                              value: '0',
                              detail: 'Belum ada jadwal',
                              tint: Color(0xFFE8F0FF),
                              iconColor: Color(0xFF426A9E),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: const _MetricCard(
                              icon: Icons.health_and_safety_rounded,
                              label: 'Catatan kesehatan',
                              value: '0',
                              detail: 'Belum ada catatan',
                              tint: Color(0xFFFFF0E3),
                              iconColor: Color(0xFF9B6338),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: const _MetricCard(
                              icon: Icons.house_rounded,
                              label: 'Habitat',
                              value: '0',
                              detail: 'Belum ada habitat',
                              tint: Color(0xFFECEBFA),
                              iconColor: Color(0xFF625C9B),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 27),
                  Text(
                    'Mulai dari sini',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 13),
                  LayoutBuilder(
                    builder: (context, box) {
                      final wide = box.maxWidth >= 760;
                      final first = _ActionCard(
                        icon: Icons.add_circle_outline_rounded,
                        title: mode == WorkspaceMode.personal
                            ? 'Tambahkan hewan pertama'
                            : 'Tambahkan hewan atau kelompok',
                        description: mode == WorkspaceMode.personal
                            ? 'Buat profil untuk mulai menyimpan informasi dan kebutuhan perawatan.'
                            : 'Mulai susun daftar hewan yang dikelola di ruang kerja ini.',
                        action: 'Buka pengelolaan hewan',
                        onPressed: onOpenAnimals,
                      );
                      final second = _ActionCard(
                        icon: Icons.event_available_outlined,
                        title: 'Atur rutinitas perawatan',
                        description:
                            'Siapkan jadwal pemberian pakan, kebersihan, pemeriksaan, dan kegiatan rutin lainnya.',
                        action: 'Lihat jadwal',
                        onPressed: onOpenSchedule,
                      );
                      if (wide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: first),
                            const SizedBox(width: 13),
                            Expanded(child: second),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          first,
                          const SizedBox(height: 12),
                          second,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: colors.outlineVariant.withValues(alpha: 0.65),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.wifi_off_rounded, color: colors.primary),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dirancang untuk tetap siap saat offline',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Data akan disimpan secara lokal terlebih dahulu. Sinkronisasi cloud menjadi bagian dari tahap pengembangan berikutnya.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      height: 1.45,
                                    ),
                              ),
                            ],
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
      },
    );
  }
}

class _WorkspaceCard extends StatelessWidget {
  const _WorkspaceCard({required this.mode, required this.onChanged});

  final WorkspaceMode mode;
  final ValueChanged<WorkspaceMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primaryContainer.withValues(alpha: 0.78),
            colors.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                mode == WorkspaceMode.personal
                    ? Icons.person_rounded
                    : Icons.workspaces_rounded,
                color: colors.primary,
              ),
              const SizedBox(width: 9),
              Text(
                'Ruang ${mode.label}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Aktif',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            mode == WorkspaceMode.personal
                ? 'Kelola hewan milik pribadi beserta profil, habitat, jadwal, dan riwayat perawatannya.'
                : 'Kelola banyak hewan dan aktivitas perawatan dalam satu ruang kerja profesional.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 13),
          SegmentedButton<WorkspaceMode>(
            segments: const [
              ButtonSegment(
                value: WorkspaceMode.personal,
                label: Text('Personal'),
                icon: Icon(Icons.person_outline),
              ),
              ButtonSegment(
                value: WorkspaceMode.professional,
                label: Text('Professional'),
                icon: Icon(Icons.work_outline),
              ),
            ],
            selected: {mode},
            showSelectedIcon: false,
            onSelectionChanged: (values) => onChanged(values.first),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
    required this.tint,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;
  final Color tint;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minHeight: 132),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: iconColor, size: 19),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 3),
          Text(
            detail,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.action,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String description;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.primary, size: 25),
          const SizedBox(height: 11),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 14),
          OutlinedButton(onPressed: onPressed, child: Text(action)),
        ],
      ),
    );
  }
}
