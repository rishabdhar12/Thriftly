import 'dart:convert';
import 'dart:developer';

import 'package:budgeting_app/features/categories/data/models/categories_model.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/categories_state.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteFirebaseCategoriesBloc
    extends Bloc<RemoteFirebaseConfigEvent, RemoteFirebaseConfigState> {
  final FirebaseRemoteConfig _firebaseRemoteConfig;
  RemoteFirebaseCategoriesBloc(this._firebaseRemoteConfig)
      : super(RemoteFirebaseConfigInitialState()) {
    on<GetCategories>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategories event,
    Emitter<RemoteFirebaseConfigState> emit,
  ) async {
    emit(RemoteFirebaseConfigLoadingState());
    try {
      await _firebaseRemoteConfig.fetchAndActivate();
      final configValue = _firebaseRemoteConfig.getString('categories');
      final jsonData = jsonDecode(configValue);
      final categoriesModel = categoriesModelFromJson(jsonEncode(jsonData));
      emit(RemoteFirebaseConfigFinishedState(categoriesModel));
    } catch (error) {
      log(error.toString());
      emit(RemoteFirebaseConfigErrorState(error.toString()));
    }
  }
}
