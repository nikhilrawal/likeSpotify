import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {
  @override
  Future<Either> signin(SignInUserReq user) async {
    return await sl<AuthFirebaseService>().signin(user);
  }

  @override
  Future<Either> signup(CreateUserReq user) async {
    // TODO: implement signup
    return await sl<AuthFirebaseService>().signup(user);
  }

  @override
  Future<Either> GetUser() async {
    return await sl<AuthFirebaseService>().GetUser();
  }
}
