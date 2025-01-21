import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/domain/usecases/song/isfavoritesong.dart';
import 'package:spotify/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getPlaylist();
  Future<Either> addorRemoveFavoriteSongs(String songid);
  Future<bool> isfavoriteSong(String songid);
  Future<Either> getuserfavoritesongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];

      // Retrieve all documents in the 'songs' collection
      var collection =
          await FirebaseFirestore.instance.collection('songs').get();

      // Iterate over each document in the collection
      for (var doc in collection.docs) {
        // Access the fields of the current document
        var data = doc.data();

        // Convert the document data to a SongModel
        var songModel = SongModel.fromJson(data);

        // Check if the song is a favorite
        bool isFavorite =
            await sl<Isfavoritesongusecase>().call(params: doc.reference.id);

        // Add additional details to the songModel
        songModel.isfavorite = isFavorite;
        songModel.songid = doc.reference.id;

        // Convert to SongEntity and add to the list
        songs.add(songModel.toEntity());
      }

      return Right(songs); // Return all songs
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
      return Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();
      for (var element in data.docs) {
        var songmodel = SongModel.fromJson(element.data());
        bool isfavorite = await sl<Isfavoritesongusecase>()
            .call(params: element.reference.id);
        songmodel.isfavorite = isfavorite;
        songmodel.songid = element.reference.id;
        songs.add(songmodel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> addorRemoveFavoriteSongs(String songid) async {
    // TODO: implement addorRemoveFavoriteSongs
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseAuth.currentUser;
      late bool isfavorite;
      String uId = user!.uid;
      QuerySnapshot favoritesongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songid', isEqualTo: songid)
          .get();
      if (favoritesongs.docs.isNotEmpty) {
        isfavorite = false;
        await favoritesongs.docs.first.reference.delete();
      } else {
        isfavorite = true;
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songid': songid, 'addedDate': Timestamp.now()});
      }
      return Right(isfavorite);
    } catch (e) {
      return Left('An error occurred' + '${e}');
    }
  }

  @override
  Future<bool> isfavoriteSong(String songid) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoritesongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songid', isEqualTo: songid)
          .get();
      if (favoritesongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getuserfavoritesongs() async {
    try {
      List<SongEntity> favoritesongs = [];
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();
      for (var element in favoriteSnapshot.docs) {
        String songid = element['songid'];
        var song =
            await firebaseFirestore.collection('songs').doc(songid).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isfavorite = true;
        songModel.songid = songid;
        favoritesongs.add(songModel.toEntity());
      }
      return Right(favoritesongs);
    } catch (e) {
      return Left(e);
    }
  }
}
