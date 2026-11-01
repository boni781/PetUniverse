import 'dart:async';

import 'package:flutter/material.dart';

import 'core/database/app_database.dart';
import 'core/theme/app_theme.dart';
import 'core/workspace/workspace_mode.dart';
import 'features/shell/presentation/app_shell.dart';
import 'features/workspaces/data/workspace_repository.dart';

class PetUniverseApp extends StatefulWidget {
  const PetUniverseApp({
    super.key,
    this.database,
  });

  /// Optional database injection is used by widget and integration tests.
  final AppDatabase? database;

  @override
  State<PetUniverseApp> createState() => _PetUniverseAppState();
}

class _PetUniverseAppState extends State<PetUniverseApp> {
  late final AppDatabase _database;
  late final bool _ownsDatabase;
  bool _databaseClosed = false;
  late Future<Map<WorkspaceMode, String>> _workspaceIds;

  @override
  void initState() {
    super.initState();
    _ownsDatabase = widget.database == null;
    _database = widget.database ?? AppDatabase();
    _workspaceIds = _loadWorkspaces();
  }

  Future<Map<WorkspaceMode, String>> _loadWorkspaces() {
    return WorkspaceRepository(_database).ensureDefaultWorkspaces();
  }

  void _retryDatabaseStartup() {
    setState(() => _workspaceIds = _loadWorkspaces());
  }

  Future<void> _prepareForUpdate() async {
    if (!_ownsDatabase || _databaseClosed) return;
    await _database.close();
    _databaseClosed = true;
  }

  @override
  void dispose() {
    if (_ownsDatabase && !_databaseClosed) {
      unawaited(_database.close());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetUniverse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: FutureBuilder<Map<WorkspaceMode, String>>(
        future: _workspaceIds,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return _DatabaseStartupError(
              error: snapshot.error,
              onRetry: _retryDatabaseStartup,
            );
          }

          return AppShell(
            database: _database,
            workspaceIds: snapshot.data!,
            onPrepareForUpdate: _prepareForUpdate,
          );
        },
      ),
    );
  }
}

class _DatabaseStartupError extends StatelessWidget {
  const _DatabaseStartupError({
    required this.error,
    required this.onRetry,
  });

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.storage_rounded, size: 42),
                const SizedBox(height: 16),
                Text(
                  'Database lokal belum dapat dibuka',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  error?.toString() ?? 'Kesalahan tidak diketahui.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
