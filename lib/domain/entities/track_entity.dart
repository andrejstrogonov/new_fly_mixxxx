import 'package:equatable/equatable.dart';

/// Track Entity - представляет аудиотрек
class TrackEntity extends Equatable {
  final String id;
  final String name;
  final String path;
  final Duration? duration;
  final String? artist;
  final String? album;
  final DateTime? dateAdded;

  const TrackEntity({
    required this.id,
    required this.name,
    required this.path,
    this.duration,
    this.artist,
    this.album,
    this.dateAdded,
  });

  /// Получает имя трека без расширения
  String get displayName {
    final withoutExt = name.contains('.')
        ? name.substring(0, name.lastIndexOf('.'))
        : name;
    return withoutExt.length > 30
        ? '${withoutExt.substring(0, 27)}...'
        : withoutExt;
  }

  /// Получает полную информацию о треке
  String get fullInfo => '$displayName${artist != null ? ' - $artist' : ''}';

  TrackEntity copyWith({
    String? id,
    String? name,
    String? path,
    Duration? duration,
    String? artist,
    String? album,
    DateTime? dateAdded,
  }) {
    return TrackEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      duration: duration ?? this.duration,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  @override
  List<Object?> get props => [id, name, path, duration, artist, album, dateAdded];
}

