import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:refresh_flutter/data/models/auth/create_user_request.dart';
import 'package:refresh_flutter/data/models/auth/sigin_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserRequest createUserRequest);
  Future<Either> signIn(SignInUserRequest signInUserRequest);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SignInUserRequest signInUserRequest) async {
      try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserRequest.email,
        password: signInUserRequest.password,
      );

      return const Right("SingIn was Successfull");
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'invalid-email') {
        errorMessage = "User with this email doesn't exist.";
      } else if (e.code == 'invalid-credential') {
        errorMessage = "The password is invalid for the given email.";
      }
      return Left(errorMessage);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );

      return const Right("SingUp Successfull");
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'weak-password') {
        errorMessage = "password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
      }
      return Left(errorMessage);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
