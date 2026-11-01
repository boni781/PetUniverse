import 'dart:convert';
import 'dart:io';

import '../../../core/app_version.dart';

class UpdateException implements Exception {
  const UpdateException(this.message);

  final String message;

  @override
  String toString() => message;
}

class UpdateRelease {
  const UpdateRelease({
    required this.currentVersion,
    required this.latestVersion,
    required this.tagName,
    required this.releaseUrl,
    required this.releaseNotes,
    required this.downloadUrl,
    required this.checksumUrl,
    required this.assetName,
  });

  final String currentVersion;
  final String latestVersion;
  final String tagName;
  final Uri releaseUrl;
  final String releaseNotes;
  final Uri downloadUrl;
  final Uri checksumUrl;
  final String assetName;

  bool get updateAvailable =>
      UpdateService.compareVersions(latestVersion, currentVersion) > 0;
}

class UpdateService {
  UpdateService({
    HttpClient? httpClient,
    String? owner,
    String? repository,
  })  : _httpClient = httpClient ?? HttpClient(),
        _owner = owner ??
            const String.fromEnvironment(
              'PETUNIVERSE_UPDATE_OWNER',
              defaultValue: 'boni781',
            ),
        _repository = repository ??
            const String.fromEnvironment(
              'PETUNIVERSE_UPDATE_REPOSITORY',
              defaultValue: 'PetUniverse',
            );

  final HttpClient _httpClient;
  final String _owner;
  final String _repository;

  static const String _assetPrefix = 'PetUniverse-Windows-x64-';

  Future<UpdateRelease> checkLatestRelease() async {
    if (!Platform.isWindows) {
      throw const UpdateException(
        'Pengecekan pembaruan otomatis saat ini hanya tersedia untuk Windows.',
      );
    }

    final uri = Uri.https(
      'api.github.com',
      '/repos/$_owner/$_repository/releases/latest',
    );

    final response = await _getJson(uri);
    final tagName = (response['tag_name'] as String? ?? '').trim();
    final latestVersion = _cleanVersion(tagName);
    if (latestVersion.isEmpty) {
      throw const UpdateException(
        'GitHub Release tidak memiliki tag versi yang valid.',
      );
    }

    final releaseUrl = Uri.tryParse(response['html_url'] as String? ?? '');
    if (releaseUrl == null || !releaseUrl.hasScheme) {
      throw const UpdateException('URL halaman release tidak valid.');
    }

    const currentVersion = AppVersion.version;
    final updateAvailable =
        compareVersions(latestVersion, currentVersion) > 0;

    if (!updateAvailable) {
      return UpdateRelease(
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        tagName: tagName,
        releaseUrl: releaseUrl,
        releaseNotes: response['body'] as String? ?? '',
        downloadUrl: Uri(),
        checksumUrl: Uri(),
        assetName: '',
      );
    }

    final assets = response['assets'];
    if (assets is! List) {
      throw const UpdateException(
        'Daftar file pada GitHub Release tidak dapat dibaca.',
      );
    }

    final expectedAssetName = '$_assetPrefix$tagName.zip';
    Map<String, dynamic>? packageAsset;
    Map<String, dynamic>? checksumAsset;

    for (final rawAsset in assets) {
      if (rawAsset is! Map) continue;
      final asset = Map<String, dynamic>.from(rawAsset);
      final name = asset['name'] as String? ?? '';
      if (name == expectedAssetName) packageAsset = asset;
      if (name == 'SHA256SUMS.txt') checksumAsset = asset;
    }

    if (packageAsset == null) {
      throw UpdateException(
        'File $expectedAssetName tidak ditemukan pada GitHub Release $tagName.',
      );
    }
    if (checksumAsset == null) {
      throw const UpdateException(
        'SHA256SUMS.txt tidak ditemukan. Pembaruan dibatalkan demi keamanan.',
      );
    }

    final packageUrl = Uri.tryParse(
      packageAsset['browser_download_url'] as String? ?? '',
    );
    final checksumUrl = Uri.tryParse(
      checksumAsset['browser_download_url'] as String? ?? '',
    );

    if (packageUrl == null ||
        checksumUrl == null ||
        !packageUrl.hasScheme ||
        !checksumUrl.hasScheme) {
      throw const UpdateException('URL aset GitHub Release tidak valid.');
    }

    return UpdateRelease(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      tagName: tagName,
      releaseUrl: releaseUrl,
      releaseNotes: response['body'] as String? ?? '',
      downloadUrl: packageUrl,
      checksumUrl: checksumUrl,
      assetName: expectedAssetName,
    );
  }

  Future<void> downloadAndStart(UpdateRelease release) async {
    if (!Platform.isWindows) {
      throw const UpdateException(
        'Pemasangan pembaruan otomatis hanya tersedia untuk Windows.',
      );
    }
    if (!release.updateAvailable || release.assetName.isEmpty) {
      throw const UpdateException('Tidak ada pembaruan yang perlu dipasang.');
    }

    final localAppData = Platform.environment['LOCALAPPDATA'];
    final dataRoot = localAppData == null || localAppData.trim().isEmpty
        ? Directory.systemTemp.path
        : localAppData;
    final updateDirectory = Directory(
      '$dataRoot\\PetUniverse\\updates',
    );
    await updateDirectory.create(recursive: true);

    final archiveFile = File(
      '${updateDirectory.path}\\${release.assetName}',
    );

    await _downloadFile(release.downloadUrl, archiveFile);
    final checksumText = await _downloadText(release.checksumUrl);
    final expectedHash = _readExpectedHash(
      checksumText,
      release.assetName,
    );

    final executable = File(Platform.resolvedExecutable);
    final installDirectory = executable.parent;
    final executableName = executable.uri.pathSegments.isEmpty
        ? 'pet_universe.exe'
        : Uri.decodeComponent(executable.uri.pathSegments.last);
    final installedHelper = File(
      '${installDirectory.path}\\updater\\apply_update.ps1',
    );

    if (!await installedHelper.exists()) {
      throw const UpdateException(
        'Helper updater tidak ditemukan. Instalasi aplikasi perlu diperbaiki.',
      );
    }

    final helperCopy = File(
      '${updateDirectory.path}\\apply_update.ps1',
    );
    await installedHelper.copy(helperCopy.path);

    final processId = pid;
    final process = await Process.start(
      'powershell.exe',
      [
        '-NoProfile',
        '-NonInteractive',
        '-ExecutionPolicy',
        'Bypass',
        '-File',
        helperCopy.path,
        '-InstallDirectory',
        installDirectory.path,
        '-ArchivePath',
        archiveFile.path,
        '-ExpectedSha256',
        expectedHash,
        '-ProcessId',
        processId.toString(),
        '-ExecutableName',
        executableName,
      ],
      mode: ProcessStartMode.detached,
      runInShell: false,
    );

    if (process.pid <= 0) {
      throw const UpdateException(
        'Windows tidak berhasil menjalankan helper pembaruan.',
      );
    }

    // The detached PowerShell helper waits for this application to exit,
    // verifies the package, swaps the app directory, then starts the new app.
    exit(0);
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    final request = await _httpClient.getUrl(uri).timeout(
          const Duration(seconds: 30),
        );
    request.headers
      ..set(HttpHeaders.acceptHeader, 'application/vnd.github+json')
      ..set(HttpHeaders.userAgentHeader, 'PetUniverse-Updater');

    final response = await request.close().timeout(
          const Duration(seconds: 60),
        );
    final body = await utf8.decodeStream(response).timeout(
          const Duration(seconds: 60),
        );

    if (response.statusCode == HttpStatus.notFound) {
      throw UpdateException(
        'GitHub tidak menemukan release yang dapat diakses di '
        '$_owner/$_repository. Updater tanpa login hanya dapat mengambil '
        'release dari repositori publik. Repositori private memerlukan '
        'server distribusi publik atau autentikasi pengguna.',
      );
    }
    if (response.statusCode == HttpStatus.forbidden) {
      throw const UpdateException(
        'GitHub membatasi permintaan updater. Coba kembali beberapa saat lagi.',
      );
    }
    if (response.statusCode != HttpStatus.ok) {
      throw UpdateException(
        'Pengecekan release gagal (HTTP ${response.statusCode}).',
      );
    }

    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const UpdateException('Respons GitHub tidak memiliki format JSON yang valid.');
    }
    return decoded;
  }

  Future<void> _downloadFile(Uri uri, File destination) async {
    final request = await _httpClient.getUrl(uri).timeout(
          const Duration(seconds: 30),
        );
    request.headers
      ..set(HttpHeaders.userAgentHeader, 'PetUniverse-Updater')
      ..set(HttpHeaders.acceptHeader, 'application/octet-stream');

    final response = await request.close().timeout(
          const Duration(minutes: 2),
        );
    if (response.statusCode != HttpStatus.ok) {
      final body = await utf8.decodeStream(response);
      throw UpdateException(
        'Unduhan paket gagal (HTTP ${response.statusCode}). $body',
      );
    }

    await response.pipe(destination.openWrite());
    if (!await destination.exists() || await destination.length() == 0) {
      throw const UpdateException('File ZIP hasil unduhan kosong.');
    }
  }

  Future<String> _downloadText(Uri uri) async {
    final request = await _httpClient.getUrl(uri).timeout(
          const Duration(seconds: 30),
        );
    request.headers
      ..set(HttpHeaders.userAgentHeader, 'PetUniverse-Updater')
      ..set(HttpHeaders.acceptHeader, 'text/plain');

    final response = await request.close().timeout(
          const Duration(seconds: 30),
        );
    if (response.statusCode != HttpStatus.ok) {
      throw UpdateException(
        'Unduhan checksum gagal (HTTP ${response.statusCode}).',
      );
    }
    return utf8.decodeStream(response);
  }

  static String _readExpectedHash(String contents, String assetName) {
    for (final line in const LineSplitter().convert(contents)) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      final match = RegExp(r'^([a-fA-F0-9]{64})\s+\*?(.+)$')
          .firstMatch(trimmed);
      if (match == null) continue;
      final filename = match.group(2)!.trim();
      if (filename == assetName) return match.group(1)!.toLowerCase();
    }
    throw const UpdateException(
      'Checksum SHA-256 untuk paket pembaruan tidak ditemukan.',
    );
  }

  static String _cleanVersion(String value) {
    return value.trim().replaceFirst(RegExp(r'^[vV]'), '');
  }

  static List<int> _versionParts(String version) {
    final cleaned = _cleanVersion(version);
    final match = RegExp(r'^(\d+)\.(\d+)\.(\d+)(?:[-+].*)?$')
        .firstMatch(cleaned);
    if (match == null) {
      throw UpdateException('Format versi tidak valid: $version');
    }
    return [
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    ];
  }

  static int compareVersions(String left, String right) {
    final a = _versionParts(left);
    final b = _versionParts(right);
    for (var index = 0; index < 3; index++) {
      if (a[index] > b[index]) return 1;
      if (a[index] < b[index]) return -1;
    }
    return 0;
  }

  void close() {
    _httpClient.close(force: true);
  }
}
