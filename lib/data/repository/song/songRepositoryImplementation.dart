import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/songs/song.dart';
import 'package:spotify/domain/repository/songs/song.dart';
import 'package:spotify/service_locator.dart';

class Songrepositoryimplementation extends SongRepository {
  @override
  Future<Either> getNewSongs() async {
    // TODO: implement getNewSongs
    return await sl<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getPlayList() async {
    // TODO: implement getPlayList
    return await sl<SongFirebaseService>().getPlaylist();
  }

  @override
  Future<Either> addorRemoveFavoriteSongs(String songid) async {
    return await sl<SongFirebaseService>().addorRemoveFavoriteSongs(songid);
  }

  @override
  Future<bool> isfavoriteSong(String songid) async {
    return await sl<SongFirebaseService>().isfavoriteSong(songid);
  }

  @override
  Future<Either> getuserfavoritesongs() async {
    return await sl<SongFirebaseService>().getuserfavoritesongs();
  }
}
