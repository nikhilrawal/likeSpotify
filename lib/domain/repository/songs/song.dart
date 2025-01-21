import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
  Future<Either> addorRemoveFavoriteSongs(String songid);
  Future<bool> isfavoriteSong(String songid);
  Future<Either> getuserfavoritesongs();
}
