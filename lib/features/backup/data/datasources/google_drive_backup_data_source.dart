import 'dart:async';
import 'dart:typed_data';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

import '../../../../core/errors/app_exception.dart';
import '../../../authentication/domain/repositories/auth_repository.dart';
import '../../domain/entities/backup_metadata.dart';
import 'backup_remote_data_source.dart';

/// [BackupRemoteDataSource] on Google Drive's hidden `appDataFolder`.
///
/// The app folder is private to Math Strike: it is invisible in the user's
/// Drive UI and the app cannot access any other Drive files.
final class GoogleDriveBackupDataSource implements BackupRemoteDataSource {
  /// Creates the data source.
  const GoogleDriveBackupDataSource(this._authorizer);

  final GoogleApiAuthorizer _authorizer;

  static const _space = 'appDataFolder';
  static const _jsonType = 'application/json';

  @override
  Future<BackupMetadata?> findLatest() => _withDrive((api) async {
    final list = await api.files.list(
      spaces: _space,
      q: "name = '$backupFileName' and trashed = false",
      orderBy: 'modifiedTime desc',
      pageSize: 1,
      $fields: 'files(id,size,modifiedTime,appProperties)',
    );
    final files = list.files ?? const <drive.File>[];
    return files.isEmpty ? null : _toMetadata(files.first);
  });

  @override
  Future<Uint8List> download(
    String id, {
    void Function(double progress)? onProgress,
  }) => _withDrive((api) async {
    final media = await api.files.get(
      id,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;
    final total = media.length;
    final bytes = BytesBuilder(copy: false);
    await for (final chunk in media.stream) {
      bytes.add(chunk);
      if (total != null && total > 0) {
        onProgress?.call((bytes.length / total).clamp(0, 1));
      }
    }
    return bytes.takeBytes();
  });

  @override
  Future<BackupMetadata> upload(
    Uint8List bytes, {
    required String appVersion,
    required int formatVersion,
  }) => _withDrive((api) async {
    final file = drive.File()
      ..name = backupFileName
      ..parents = [_space]
      ..mimeType = _jsonType
      ..appProperties = {
        'appVersion': appVersion,
        'formatVersion': '$formatVersion',
      };
    final created = await api.files.create(
      file,
      uploadMedia: drive.Media(
        Stream.value(bytes),
        bytes.length,
        contentType: _jsonType,
      ),
      $fields: 'id,size,modifiedTime,appProperties',
    );
    return _toMetadata(created);
  });

  /// Runs [action] with an authorised Drive client, mapping failures to
  /// [AppException]s and always closing the HTTP client.
  Future<T> _withDrive<T>(Future<T> Function(drive.DriveApi api) action) async {
    final client = await _authorizer.authorizedClient();
    try {
      return await action(drive.DriveApi(client));
    } on drive.DetailedApiRequestError catch (e, st) {
      if (e.status == 401 || e.status == 403) {
        throw AuthException(
          'Google Drive access was denied. Please sign in again.',
          cause: e,
          stackTrace: st,
        );
      }
      throw StorageException(
        'Google Drive request failed (${e.status})',
        cause: e,
        stackTrace: st,
      );
    } on http.ClientException catch (e, st) {
      throw NetworkException(
        'Could not reach Google Drive',
        cause: e,
        stackTrace: st,
      );
    } on TimeoutException catch (e, st) {
      throw NetworkException(
        'Google Drive did not respond',
        cause: e,
        stackTrace: st,
      );
    } finally {
      client.close();
    }
  }

  static BackupMetadata _toMetadata(drive.File file) => BackupMetadata(
    id: file.id!,
    modifiedAt: file.modifiedTime ?? DateTime.now().toUtc(),
    sizeBytes: int.tryParse(file.size ?? '') ?? 0,
    appVersion: file.appProperties?['appVersion'],
    formatVersion: int.tryParse(file.appProperties?['formatVersion'] ?? ''),
  );
}
