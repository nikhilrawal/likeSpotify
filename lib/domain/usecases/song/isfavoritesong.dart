import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/songs/song.dart';
import 'package:spotify/service_locator.dart';

class Isfavoritesongusecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isfavoriteSong(params!);
  }
}
