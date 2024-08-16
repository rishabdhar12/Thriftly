import 'package:budgeting_app/core/config/isar/isar_config.dart';
import 'package:budgeting_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/verifyotp_usecase.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/categories/data/repositories/categories_repositories_impl.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:budgeting_app/features/categories/domain/usecases/categories_usecase.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

final sl = GetIt.asNewInstance();

Future<void> setupDependencies() async {
  final isar = await openIsarInstance();
  sl.registerSingleton<Isar>(isar);

  sl.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerFactory(() => RemoteCategoriesBloc(sl()));
  sl.registerFactory(() => AuthBloc(
        signInWithPhoneNumber: sl(),
        verifyOtp: sl(),
        checkUserExist: sl(),
      ));
  sl.registerFactory(() => LocalCategoriesBloc(sl()));

  sl.registerLazySingleton(() => SignInWithPhoneNumber(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => CategoriesUsecase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CategoriesRespository>(
    () => CategoriesRepositoriesImpl(sl()),
  );
}
