import 'package:spotify/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/domain/repository/songs/song.dart';
import 'package:spotify/service_locator.dart';

class Songusecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().getNewSongs();
  }
}
