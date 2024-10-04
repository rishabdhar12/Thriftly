import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:equatable/equatable.dart';

abstract class LocalCategoriesEvent extends Equatable {
  const LocalCategoriesEvent();

  @override
  List<Object> get props => [];
}

class AddCategoryEvent extends LocalCategoriesEvent {
  final Categories category;
  const AddCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class AddCategoriesEvent extends LocalCategoriesEvent {
  final List<Categories> categories;
  const AddCategoriesEvent({required this.categories});

  @override
  List<Object> get props => [categories];
}

class GetCategoryEvent extends LocalCategoriesEvent {
  final String name;
  const GetCategoryEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class GetCategoriesEvent extends LocalCategoriesEvent {
  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}

class DeleteCategoriesEvent extends LocalCategoriesEvent {
  final int categoryId;
  const DeleteCategoriesEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class ResetCategoriesEvent extends LocalCategoriesEvent {
  const ResetCategoriesEvent();

  @override
  List<Object> get props => [];
}
