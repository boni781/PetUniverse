enum WorkspaceMode { personal, professional }

extension WorkspaceModeLabel on WorkspaceMode {
  String get label => this == WorkspaceMode.personal ? 'Personal' : 'Professional';

  String get description => this == WorkspaceMode.personal
      ? 'Ruang pribadi untuk mengelola hewan dan rutinitas perawatannya.'
      : 'Ruang kerja untuk mengelola banyak hewan, habitat, dan aktivitas tim.';
}
