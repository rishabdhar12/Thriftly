import 'package:budgeting_app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.asNewInstance();

Future<void> setupDependencies() async {
  sl.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);

  sl.registerFactory(() => RemoteFirebaseCategoriesBloc(sl()));
}
