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

class GetCategoriesEvent extends LocalCategoriesEvent {
  final String name;
  const GetCategoriesEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class DeleteCategoriesEvent extends LocalCategoriesEvent {
  final String name;
  const DeleteCategoriesEvent({required this.name});

  @override
  List<Object> get props => [name];
}
