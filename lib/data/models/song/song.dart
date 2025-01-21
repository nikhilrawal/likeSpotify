import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spotify/domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  Timestamp? releaseDate;
  num? duration;
  bool? isfavorite;
  String? songid;

  SongModel({
    required this.title,
    required this.artist,
    required this.releaseDate,
    required this.duration,
    required this.isfavorite,
    required this.songid,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'releaseDate': releaseDate,
      'duration': duration,
      'isfavorite': isfavorite,
      'songid': songid
    };
  }

  factory SongModel.fromJson(Map<String, dynamic> map) {
    return SongModel(
        songid: map['songid'],
        title: map['title'],
        artist: map['artist'],
        releaseDate: map['releaseDate'],
        duration: map['duration'],
        isfavorite: map['isfavorite']);
  }
}

extension SongModel1X on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        title: title!,
        artist: artist!,
        releaseDate: releaseDate!,
        duration: duration!,
        isfavorite: isfavorite!,
        songid: songid!);
  }
}
