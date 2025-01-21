import 'package:spotify/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class GetUserusecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl<AuthRepository>().GetUser();
  }
}
