import 'package:budgeting_app/features/authentication/data/datasource/auth_datasource.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/verifyotp_usecase.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.asNewInstance();

Future<void> setupDependencies() async {
  sl.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerFactory(() => RemoteFirebaseCategoriesBloc(sl()));
  sl.registerFactory(() => AuthBloc(
        signInWithPhoneNumber: sl(),
        verifyOtp: sl(),
      ));

  sl.registerLazySingleton(() => SignInWithPhoneNumber(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
}
