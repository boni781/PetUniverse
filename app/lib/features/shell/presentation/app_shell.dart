import 'package:flutter/material.dart';

import '../../../core/workspace/workspace_mode.dart';
import '../../home/presentation/home_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  WorkspaceMode _mode = WorkspaceMode.personal;

  static const _mobile = [
    _Destination(0, 'Beranda', Icons.space_dashboard_outlined, Icons.space_dashboard),
    _Destination(1, 'Hewan', Icons.pets_outlined, Icons.pets),
    _Destination(3, 'Jadwal', Icons.calendar_month_outlined, Icons.calendar_month),
    _Destination(6, 'Lainnya', Icons.grid_view_outlined, Icons.grid_view),
  ];

  static const _desktop = [
    _Destination(0, 'Beranda', Icons.space_dashboard_outlined, Icons.space_dashboard),
    _Destination(1, 'Hewan', Icons.pets_outlined, Icons.pets),
    _Destination(2, 'Habitat', Icons.house_outlined, Icons.house),
    _Destination(3, 'Jadwal', Icons.calendar_month_outlined, Icons.calendar_month),
    _Destination(4, 'Kesehatan', Icons.health_and_safety_outlined, Icons.health_and_safety),
    _Destination(5, 'Katalog spesies', Icons.menu_book_outlined, Icons.menu_book),
    _Destination(6, 'Lainnya', Icons.grid_view_outlined, Icons.grid_view),
  ];

  void _go(int index) => setState(() => _index = index);
  void _setMode(WorkspaceMode mode) => setState(() => _mode = mode);

  Widget _currentPage() {
    if (_index == 0) {
      return HomePage(
        mode: _mode,
        onModeChanged: _setMode,
        onOpenAnimals: () => _go(1),
        onOpenSchedule: () => _go(3),
      );
    }
    return _SectionPage(index: _index, mode: _mode, onNavigate: _go);
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 960;
    final mobileIndex = _mobile.indexWhere((item) => item.index == _index);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              _SideMenu(
                selected: _index,
                mode: _mode,
                onSelect: _go,
                onModeChanged: _setMode,
              ),
            Expanded(
              child: Column(
                children: [
                  if (wide)
                    _DesktopHeader(mode: _mode, onModeChanged: _setMode)
                  else
                    _MobileHeader(mode: _mode, onModeChanged: _setMode),
                  Expanded(child: _currentPage()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: mobileIndex < 0 ? 3 : mobileIndex,
              onDestinationSelected: (i) => _go(_mobile[i].index),
              destinations: [
                for (final item in _mobile)
                  NavigationDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: item.label,
                  ),
              ],
            ),
    );
  }
}

class _Destination {
  const _Destination(this.index, this.label, this.icon, this.selectedIcon);
  final int index;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({
    required this.selected,
    required this.mode,
    required this.onSelect,
    required this.onModeChanged,
  });

  final int selected;
  final WorkspaceMode mode;
  final ValueChanged<int> onSelect;
  final ValueChanged<WorkspaceMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 246,
      padding: const EdgeInsets.fromLTRB(17, 22, 17, 15),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          right: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.6)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(Icons.pets_rounded, color: colors.onPrimaryContainer),
              ),
              const SizedBox(width: 10),
              Text(
                'PetUniverse',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'RUANG KERJA',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 9),
          _SidebarModePicker(mode: mode, onChanged: onModeChanged),
          const SizedBox(height: 25),
          Text(
            'MENU UTAMA',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (final item in _AppShellState._desktop)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Material(
                      color: selected == item.index
                          ? colors.secondaryContainer
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => onSelect(item.index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selected == item.index ? item.selectedIcon : item.icon,
                                size: 20,
                                color: selected == item.index
                                    ? colors.onSecondaryContainer
                                    : colors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 11),
                              Text(
                                item.label,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: selected == item.index
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 24),
          Row(
            children: [
              Icon(Icons.cloud_off_outlined, color: colors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                'Mode offline-first',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidebarModePicker extends StatelessWidget {
  const _SidebarModePicker({required this.mode, required this.onChanged});

  final WorkspaceMode mode;
  final ValueChanged<WorkspaceMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<WorkspaceMode>(
          value: mode,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: [
            for (final item in WorkspaceMode.values)
              DropdownMenuItem(
                value: item,
                child: Text(item.label, overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({required this.mode, required this.onModeChanged});
  final WorkspaceMode mode;
  final ValueChanged<WorkspaceMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: [
          const Spacer(),
          _ModeSelector(mode: mode, onChanged: onModeChanged),
          const SizedBox(width: 17),
          CircleAvatar(
            radius: 19,
            backgroundColor: colors.primaryContainer,
            child: Icon(Icons.person_outline, color: colors.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader({required this.mode, required this.onModeChanged});
  final WorkspaceMode mode;
  final ValueChanged<WorkspaceMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 13, 15, 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.pets_rounded, color: colors.onPrimaryContainer),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'PetUniverse',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          PopupMenuButton<WorkspaceMode>(
            tooltip: 'Ganti ruang kerja',
            onSelected: onModeChanged,
            itemBuilder: (context) => [
              for (final value in WorkspaceMode.values)
                PopupMenuItem(value: value, child: Text(value.label)),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    mode == WorkspaceMode.personal
                        ? Icons.person_outline
                        : Icons.work_outline,
                    size: 17,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    mode.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 17),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeSelector extends StatelessWidget {
  const _ModeSelector({required this.mode, required this.onChanged});
  final WorkspaceMode mode;
  final ValueChanged<WorkspaceMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<WorkspaceMode>(
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
    );
  }
}

class _SectionPage extends StatelessWidget {
  const _SectionPage({
    required this.index,
    required this.mode,
    required this.onNavigate,
  });

  final int index;
  final WorkspaceMode mode;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    if (index == 6) return _MorePage(onNavigate: onNavigate);

    final config = switch (index) {
      1 => const _PageInfo(
          'MANAJEMEN',
          'Pengelolaan hewan',
          'Belum ada profil hewan',
          'Profil hewan akan ditampilkan di sini, beserta identitas, spesies, habitat, dan riwayat perawatannya.',
          Icons.pets_rounded,
          'Lihat katalog spesies',
          5,
          'Form profil dan penyimpanan data akan dibuat setelah struktur data inti ditetapkan.',
        ),
      2 => const _PageInfo(
          'LINGKUNGAN',
          'Habitat dan kandang',
          'Belum ada habitat',
          'Data lokasi, tipe lingkungan, kapasitas, dan hewan yang menempatinya akan ditampilkan di sini.',
          Icons.house_rounded,
          'Kembali ke daftar hewan',
          1,
          'Riwayat habitat dirancang agar perpindahan tempat tinggal tidak menghapus catatan sebelumnya.',
        ),
      3 => const _PageInfo(
          'RUTINITAS',
          'Jadwal perawatan',
          'Belum ada jadwal perawatan',
          'Jadwal pemberian pakan, pembersihan, pengukuran, dan kegiatan lainnya akan muncul di halaman ini.',
          Icons.calendar_month_rounded,
          'Lihat hewan',
          1,
          'Pengingat akan dirancang agar tetap dapat digunakan tanpa koneksi internet.',
        ),
      4 => const _PageInfo(
          'KESEHATAN',
          'Catatan kesehatan',
          'Belum ada catatan kesehatan',
          'Riwayat pemeriksaan, pengamatan, tindakan, dan dokumen pendukung akan tersusun berdasarkan tanggal.',
          Icons.health_and_safety_rounded,
          'Lihat profil hewan',
          1,
          'PetUniverse berfungsi sebagai pencatat informasi. Diagnosis dan keputusan medis tetap memerlukan tenaga profesional yang sesuai.',
        ),
      _ => const _PageInfo(
          'REFERENSI',
          'Katalog spesies',
          'Katalog sedang disiapkan',
          'Katalog akan dibangun bertahap dengan atribut yang berbeda menurut spesies, tahap hidup, dan habitat.',
          Icons.menu_book_rounded,
          'Kembali ke beranda',
          0,
          'Informasi referensi perlu menyertakan sumber. Nilai yang belum diketahui tidak akan dianggap nol.',
        ),
    };

    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                config.eyebrow,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                config.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                index == 1 ? mode.description : 'Kelola informasi secara terstruktur dalam satu ruang PetUniverse.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.7)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Icon(config.icon, size: 32, color: colors.onPrimaryContainer),
                    ),
                    const SizedBox(height: 17),
                    Text(
                      config.emptyTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 540),
                      child: Text(
                        config.emptyDescription,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.5,
                            ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    FilledButton.icon(
                      onPressed: () => onNavigate(config.destination),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: Text(config.action),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded, color: colors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        config.note,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.5,
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

class _PageInfo {
  const _PageInfo(
    this.eyebrow,
    this.title,
    this.emptyTitle,
    this.emptyDescription,
    this.icon,
    this.action,
    this.destination,
    this.note,
  );
  final String eyebrow;
  final String title;
  final String emptyTitle;
  final String emptyDescription;
  final IconData icon;
  final String action;
  final int destination;
  final String note;
}

class _MorePage extends StatelessWidget {
  const _MorePage({required this.onNavigate});
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jelajahi PetUniverse',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 7),
          Text(
            'Akses modul lain yang melengkapi pengelolaan hewan.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 20),
          _MoreTile(
            icon: Icons.house_outlined,
            title: 'Habitat dan kandang',
            subtitle: 'Lokasi, lingkungan, dan riwayat perpindahan',
            onTap: () => onNavigate(2),
          ),
          _MoreTile(
            icon: Icons.health_and_safety_outlined,
            title: 'Catatan kesehatan',
            subtitle: 'Pemeriksaan dan riwayat kondisi',
            onTap: () => onNavigate(4),
          ),
          _MoreTile(
            icon: Icons.menu_book_outlined,
            title: 'Katalog spesies',
            subtitle: 'Referensi spesies dan kebutuhan perawatan',
            onTap: () => onNavigate(5),
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: colors.onPrimaryContainer),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
