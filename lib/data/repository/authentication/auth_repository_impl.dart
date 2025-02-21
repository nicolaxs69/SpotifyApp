import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/data/models/auth/create_user_request.dart';
import 'package:refresh_flutter/data/models/auth/sigin_user_request.dart';
import 'package:refresh_flutter/data/sources/authentication/auth_firebase_service.dart';
import 'package:refresh_flutter/domain/repository/authentication/auth_repository.dart';
import 'package:refresh_flutter/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SignInUserRequest signInUserRequest) async {
    return await serviceLocator<AuthFirebaseService>()
        .signIn(signInUserRequest);
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    return await serviceLocator<AuthFirebaseService>()
        .signUp(createUserRequest);
  }
}
