import 'dart:convert';
import 'dart:developer';

import 'package:budgeting_app/features/categories/data/models/categories_model.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_state.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteCategoriesBloc
    extends Bloc<RemoteCategoriesEvent, RemoteCategoriesState> {
  final FirebaseRemoteConfig _firebaseRemoteConfig;
  RemoteCategoriesBloc(this._firebaseRemoteConfig)
      : super(RemoteCategoriesInitialState()) {
    on<GetCategories>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategories event,
    Emitter<RemoteCategoriesState> emit,
  ) async {
    emit(RemoteCategoriesLoadingState());
    try {
      await _firebaseRemoteConfig.fetchAndActivate();
      final configValue = _firebaseRemoteConfig.getString('categories');
      final jsonData = jsonDecode(configValue);
      final categoriesModel = categoriesModelFromJson(jsonEncode(jsonData));
      emit(RemoteCategoriesFinishedState(categoriesModel));
    } catch (error) {
      log(error.toString());
      emit(RemoteCategoriesErrorState(error.toString()));
    }
  }
}
