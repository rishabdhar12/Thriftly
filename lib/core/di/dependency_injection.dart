import 'package:budgeting_app/core/config/isar/isar_config.dart';
import 'package:budgeting_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/check_user_exists_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/verifyotp_usecase.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/categories/data/repositories/categories_repositories_impl.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:budgeting_app/features/categories/domain/usecases/add_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/delete_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/get_category_usecase.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_bloc.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Bloc
  sl.registerFactory(() => RemoteCategoriesBloc(sl()));
  sl.registerFactory(() => AuthBloc(
        signInWithPhoneNumber: sl(),
        verifyOtp: sl(),
        checkUserExist: sl(),
        signUp: sl(),
      ));
  sl.registerFactory(() => LocalCategoriesBloc(
        categoriesUsecase: sl(),
        deleteCategoriesUsecase: sl(),
        getCategoriesUsecase: sl(),
      ));
  sl.registerFactory(() => BottomNavigationBloc());

  // Usecase
  sl.registerLazySingleton(() => SignInWithPhoneNumber(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => CategoriesUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => CheckUserExist(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CategoriesRespository>(
    () => CategoriesRepositoriesImpl(sl()),
  );
}
