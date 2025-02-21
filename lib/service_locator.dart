import 'package:get_it/get_it.dart';
import 'package:refresh_flutter/data/repository/authentication/auth_repository_impl.dart';
import 'package:refresh_flutter/data/sources/authentication/auth_firebase_service.dart';
import 'package:refresh_flutter/domain/repository/authentication/auth_repository.dart';
import 'package:refresh_flutter/domain/usecases/authentication/signin.dart';
import 'package:refresh_flutter/domain/usecases/authentication/signup.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  
  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

    serviceLocator.registerSingleton<SignupUseCase>(
    SignupUseCase(),
  );

  serviceLocator.registerSingleton<SigninUseCase>(
    SigninUseCase(),
  );
}