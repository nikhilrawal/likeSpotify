import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/domain/usecases/song/addorremovesong.dart';
import 'package:spotify/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {
    var result = await sl<Addorremovesongusecase>().call(params: songId);
    result.fold(
      (l) {},
      (isfavorite) {
        emit(FavoriteButtonUpdated(isfavorite: isfavorite));
      },
    );
  }
}
