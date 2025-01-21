import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify/data/repository/song/songRepositoryImplementation.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/songs/song.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/repository/songs/song.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/domain/usecases/auth/signinUsecase.dart';
import 'package:spotify/domain/usecases/auth/signupUsecase.dart';
import 'package:spotify/domain/usecases/song/addorremovesong.dart';
import 'package:spotify/domain/usecases/song/getPlaylist.dart';
import 'package:spotify/domain/usecases/song/getsongsusecase.dart';
import 'package:spotify/domain/usecases/song/getuserfavoritesongsusecase.dart';
import 'package:spotify/domain/usecases/song/isfavoritesong.dart';

final sl = GetIt.instance;
Future<void> initializeDepencies() async {
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImplementation());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImplementation());
  sl.registerSingleton<SongRepository>(Songrepositoryimplementation());
  sl.registerSingleton<Signupusecase>(Signupusecase());
  sl.registerSingleton<Signinusecase>(Signinusecase());
  sl.registerSingleton<Songusecase>(Songusecase());
  sl.registerSingleton<GetplaylistUsecase>(GetplaylistUsecase());
  sl.registerSingleton<Addorremovesongusecase>(Addorremovesongusecase());
  sl.registerSingleton<Isfavoritesongusecase>(Isfavoritesongusecase());
  sl.registerSingleton<GetUserusecase>(GetUserusecase());
  sl.registerSingleton<Getuserfavoritesongsusecase>(
      Getuserfavoritesongsusecase());
}
