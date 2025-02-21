import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/core/usecase/usecase.dart';
import 'package:refresh_flutter/data/models/auth/create_user_request.dart';
import 'package:refresh_flutter/domain/repository/authentication/auth_repository.dart';
import 'package:refresh_flutter/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call(CreateUserRequest params) async {
    return serviceLocator<AuthRepository>().signUp(params);
  }
}
