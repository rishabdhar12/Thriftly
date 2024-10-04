import 'dart:developer';

import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/add_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/add_category_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/delete_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/get_category_usecase.dart';
import 'package:budgeting_app/features/categories/domain/usecases/reset_categories_usecase.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalCategoriesBloc
    extends Bloc<LocalCategoriesEvent, LocalCategoriesState> {
  final CategoryUsecase categoryUsecase;
  final CategoriesUsecase categoriesUsecase;
  final GetCategoryUsecase getCategoryUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  final DeleteCategoriesUsecase deleteCategoriesUsecase;
  final ResetCategoriesUsecase resetCategoriesUsecase;
  LocalCategoriesBloc({
    required this.categoryUsecase,
    required this.categoriesUsecase,
    required this.getCategoryUsecase,
    required this.getCategoriesUsecase,
    required this.deleteCategoriesUsecase,
    required this.resetCategoriesUsecase,
  }) : super(LocalCategoriesInitialState()) {
    on<AddCategoryEvent>(_onAddCategory);
    on<AddCategoriesEvent>(_onAddCategories);
    on<GetCategoryEvent>(_onGetCategory);
    on<GetCategoriesEvent>(_onGetCategories);
    on<DeleteCategoriesEvent>(_onDeleteCategories);
    on<ResetCategoriesEvent>(_onResetCategories);
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());

    try {
      final addCategoryResponse = await categoryUsecase(event.category);

      if (addCategoryResponse.isLeft()) {
        final failure = addCategoryResponse.getLeft().toNullable();
        emit(LocalCategoriesErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final getCategoriesResponse = await getCategoriesUsecase(NoParams());

      if (getCategoriesResponse.isLeft()) {
        final failure = getCategoriesResponse.getLeft().toNullable();
        emit(LocalCategoriesErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final categories = getCategoriesResponse.getRight().toNullable();
      emit(LocalCategoriesFetchedState(categories ?? []));
    } catch (error) {
      emit(LocalCategoriesErrorState(error.toString()));
    }
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
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }

  Future<void> _onGetCategory(
    GetCategoryEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final response = await getCategoryUsecase(event.name);
      response.fold(
        (failure) => emit(LocalCategoriesErrorState(failure.message)),
        (categories) {
          emit(LocalCategoryFetchedState(categories));
        },
      );
    } catch (error) {
      log(error.toString());
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final response = await getCategoriesUsecase(NoParams());
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
      final response = await deleteCategoriesUsecase(event.categoryId);
      response.fold(
        (failure) => emit(LocalCategoriesErrorState(failure.message)),
        (result) => emit(LocalCategoriesDeletedState(result)),
      );
    } catch (error) {
      log(error.toString());
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }

  Future<void> _onResetCategories(
    ResetCategoriesEvent event,
    Emitter<LocalCategoriesState> emit,
  ) async {
    emit(LocalCategoriesLoadingState());
    try {
      final resetCategoryResponse = await resetCategoriesUsecase(NoParams());
      if (resetCategoryResponse.isLeft()) {
        final failure = resetCategoryResponse.getLeft().toNullable();
        emit(LocalCategoriesErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final getCategoriesResponse = await getCategoriesUsecase(NoParams());

      if (getCategoriesResponse.isLeft()) {
        final failure = getCategoriesResponse.getLeft().toNullable();
        emit(LocalCategoriesErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final categories = getCategoriesResponse.getRight().toNullable();
      emit(LocalCategoriesFetchedState(categories ?? []));
    } catch (error) {
      emit(LocalCategoriesErrorState(error.toString()));
    }
  }
}
