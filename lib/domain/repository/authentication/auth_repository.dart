import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/data/models/auth/create_user_request.dart';
import 'package:refresh_flutter/data/models/auth/sigin_user_request.dart';

abstract class AuthRepository {
  Future<Either> signUp(CreateUserRequest createUserRequest);
  Future<Either> signIn(SignInUserRequest signInUserRequest);
}
