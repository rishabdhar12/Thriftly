import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:equatable/equatable.dart';

abstract class LocalCategoriesState extends Equatable {
  final Categories? categories;
  final bool? result;

  const LocalCategoriesState({this.categories, this.result});

  @override
  List<Object> get props => [categories!];
}

class LocalCategoriesInitialState extends LocalCategoriesState {}

class LocalCategoriesLoadingState extends LocalCategoriesState {}

class LocalCategoriesFinishedState extends LocalCategoriesState {
  const LocalCategoriesFinishedState(Categories categories)
      : super(categories: categories);
}

class LocalCategoriesFetchedState extends LocalCategoriesState {
  const LocalCategoriesFetchedState(Categories categories)
      : super(categories: categories);
}

class LocalCategoriesDeletedState extends LocalCategoriesState {
  const LocalCategoriesDeletedState(bool result) : super(result: result);
}

class LocalCategoriesErrorState extends LocalCategoriesState {
  final String message;

  const LocalCategoriesErrorState(this.message);
}
