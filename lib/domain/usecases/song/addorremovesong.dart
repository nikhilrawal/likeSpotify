import 'package:spotify/core/usecase/usecase.dart';

import 'package:dartz/dartz.dart';

import 'package:spotify/domain/repository/songs/song.dart';
import 'package:spotify/service_locator.dart';

class Addorremovesongusecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addorRemoveFavoriteSongs(params!);
  }
}
