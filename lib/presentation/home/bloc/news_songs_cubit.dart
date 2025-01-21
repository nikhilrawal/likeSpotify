import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/getsongsusecase.dart';
import 'package:spotify/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<Songusecase>().call();
    returnedSongs.fold((l) {
      emit(NewsSongsLoadFailure());
    }, (r) {
      emit(NewsSongsLoaded(songs: r));
    });
  }
}
