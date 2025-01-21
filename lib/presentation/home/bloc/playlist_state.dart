import 'package:spotify/domain/entities/song/song_entity.dart';

abstract class PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;
  PlaylistLoaded({
    required this.songs,
  });
}

class PlaylistLoadFailure extends PlaylistState {}
