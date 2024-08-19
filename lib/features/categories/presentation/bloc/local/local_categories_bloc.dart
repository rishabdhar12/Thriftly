import 'dart:developer';

import 'package:budgeting_app/features/categories/domain/usecases/add_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/delete_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/get_category_usecase.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalCategoriesBloc
    extends Bloc<LocalCategoriesEvent, LocalCategoriesState> {
  final CategoriesUsecase categoriesUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  final DeleteCategoriesUsecase deleteCategoriesUsecase;
  LocalCategoriesBloc(
      {required this.categoriesUsecase,
      required this.getCategoriesUsecase,
      required this.deleteCategoriesUsecase})
      : super(LocalCategoriesInitialState()) {
    on<AddCategoriesEvent>(_onAddCategories);
    on<GetCategoriesEvent>(_onGetCategories);
    on<DeleteCategoriesEvent>(_onDeleteCategories);
  }

  Future<void> _onAddCategories(
    AddCategoriesEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final response = await categoriesUsecase(event.categories);
      response.fold(
        (failure) => emit(LocalCategoriesErrorState(failure.message)),
        (categories) => emit(LocalCategoriesFinishedState(categories)),
      );
    } catch (error) {
      // log(error.toString());
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final response = await getCategoriesUsecase(event.name);
      response.fold(
        (failure) => emit(LocalCategoriesErrorState(failure.message)),
        (categories) {
          emit(LocalCategoriesFetchedState(categories));
        },
      );
    } catch (error) {
      log(error.toString());
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }

  Future<void> _onDeleteCategories(
    DeleteCategoriesEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final response = await deleteCategoriesUsecase(event.name);
      response.fold(
        (failure) => emit(LocalCategoriesErrorState(failure.message)),
        (result) => emit(LocalCategoriesDeletedState(result)),
      );
    } catch (error) {
      log(error.toString());
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }
}
