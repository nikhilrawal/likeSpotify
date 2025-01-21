import 'package:spotify/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class Signinusecase implements Usecase<Either, SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq? params}) {
    return sl<AuthRepository>().signin(params!);
  }
}
