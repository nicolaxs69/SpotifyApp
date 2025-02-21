import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/core/usecase/usecase.dart';
import 'package:refresh_flutter/data/models/auth/sigin_user_request.dart';
import 'package:refresh_flutter/domain/repository/authentication/auth_repository.dart';
import 'package:refresh_flutter/service_locator.dart';

class SigninUseCase implements UseCase<Either, SignInUserRequest> {
  @override
  Future<Either> call(SignInUserRequest params) async {
    return serviceLocator<AuthRepository>().signIn(params);
  }
}
