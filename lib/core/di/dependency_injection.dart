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
import 'package:budgeting_app/features/categories/domain/usecases/add_category_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/delete_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/get_category_usecase.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_bloc.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_bloc.dart';
import 'package:budgeting_app/features/transactions/data/local/repositories/transaction_repository_impl.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/edit_transaction_usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_bloc.dart';
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
        categoryUsecase: sl(),
        categoriesUsecase: sl(),
        deleteCategoriesUsecase: sl(),
        getCategoryUsecase: sl(),
        getCategoriesUsecase: sl(),
      ));
  sl.registerFactory(() => BottomNavigationBloc());
  sl.registerFactory(() => LocalTransactionBloc(
        addTransactionUsecase: sl(),
        getTransactionsUsecase: sl(),
        editTransactionsUsecase: sl(),
      ));

  // Usecase
  sl.registerLazySingleton(() => SignInWithPhoneNumber(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => CategoryUsecase(sl()));
  sl.registerLazySingleton(() => CategoriesUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoryUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => CheckUserExist(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => AddTransactionUsecase(sl()));
  sl.registerLazySingleton(() => GetTransactionsUsecase(sl()));
  sl.registerLazySingleton(() => EditTransactionUsecase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CategoriesRespository>(
    () => CategoriesRepositoriesImpl(sl()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );
}
