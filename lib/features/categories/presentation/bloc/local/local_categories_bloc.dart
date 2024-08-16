import 'dart:developer';

import 'package:budgeting_app/features/categories/domain/usecases/categories_usecase.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/Local/Local_categories_state.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalCategoriesBloc
    extends Bloc<LocalCategoriesEvent, LocalCategoriesState> {
  final CategoriesUsecase _categoriesUsecase;
  LocalCategoriesBloc(this._categoriesUsecase)
      : super(LocalCategoriesInitialState()) {
    on<AddCategoriesEvent>(_onAddCategories);
  }

  Future<void> _onAddCategories(
    AddCategoriesEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final response = await _categoriesUsecase(event.categories);
      response.fold(
        (failure) => emit(LocalCategoriesErrorState(failure.message)),
        (categories) => emit(LocalCategoriesFinishedState(categories)),
      );
    } catch (error) {
      log(error.toString());
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }
}
