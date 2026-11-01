import 'package:flutter/material.dart';

import '../../../core/app_version.dart';
import '../data/update_service.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final UpdateService _service = UpdateService();

  UpdateRelease? _release;
  Object? _error;
  bool _checking = false;
  bool _installing = false;
  bool _hasChecked = false;

  @override
  void dispose() {
    _service.close();
    super.dispose();
  }

  Future<void> _checkForUpdates() async {
    setState(() {
      _checking = true;
      _error = null;
      _release = null;
      _hasChecked = false;
    });

    try {
      final result = await _service.checkLatestRelease();
      if (!mounted) return;
      setState(() {
        _release = result;
        _hasChecked = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _hasChecked = true;
      });
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _installUpdate() async {
    final release = _release;
    if (release == null || !release.updateAvailable) return;

    setState(() {
      _installing = true;
      _error = null;
    });

    try {
      await _service.downloadAndStart(release);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _installing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PEMELIHARAAN APLIKASI',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pembaruan PetUniverse',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Periksa versi terbaru dari GitHub Release. Paket pembaruan diverifikasi dengan SHA-256 sebelum file aplikasi diganti.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colors.primaryContainer,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.pets_rounded,
                            color: colors.onPrimaryContainer,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppVersion.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Text(
                                'Versi terpasang: v${AppVersion.version} (build ${AppVersion.buildNumber})',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _checking || _installing ? null : _checkForUpdates,
                        icon: _checking
                            ? const SizedBox(
                                width: 17,
                                height: 17,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.refresh_rounded),
                        label: Text(
                          _checking ? 'Memeriksa GitHub Release...' : 'Periksa pembaruan',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_checking) ...[
                const SizedBox(height: 16),
                const LinearProgressIndicator(),
              ],
              if (_error != null) ...[
                const SizedBox(height: 16),
                _StatusPanel(
                  icon: Icons.error_outline_rounded,
                  title: 'Pemeriksaan belum berhasil',
                  message: _error.toString(),
                  color: colors.error,
                ),
              ],
              if (_hasChecked && _error == null && _release != null) ...[
                const SizedBox(height: 16),
                if (_release!.updateAvailable)
                  _StatusPanel(
                    icon: Icons.system_update_alt_rounded,
                    title: 'Pembaruan tersedia',
                    message:
                        'PetUniverse v${_release!.latestVersion} tersedia. Versi terpasang saat ini v${_release!.currentVersion}.',
                    color: colors.primary,
                  )
                else
                  _StatusPanel(
                    icon: Icons.check_circle_outline_rounded,
                    title: 'Aplikasi sudah versi terbaru',
                    message:
                        'Versi terpasang v${_release!.currentVersion} sama dengan atau lebih baru daripada release terbaru v${_release!.latestVersion}.',
                    color: colors.tertiary,
                  ),
                if (_release!.updateAvailable) ...[
                  if (_release!.releaseNotes.trim().isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CATATAN RELEASE',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                          ),
                          const SizedBox(height: 9),
                          SelectableText(_release!.releaseNotes),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _installing ? null : _installUpdate,
                      icon: _installing
                          ? const SizedBox(
                              width: 17,
                              height: 17,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.download_rounded),
                      label: Text(
                        _installing
                            ? 'Menyiapkan pembaruan...'
                            : 'Unduh dan pasang v${_release!.latestVersion}',
                      ),
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 20),
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
                    Icon(Icons.shield_outlined, color: colors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Updater hanya mengganti file program. Database dan data pengguna tidak ditempatkan di folder instalasi aplikasi. Paket yang checksum-nya tidak cocok akan ditolak.',
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

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.45,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
