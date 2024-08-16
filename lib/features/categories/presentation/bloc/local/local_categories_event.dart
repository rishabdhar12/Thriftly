import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:equatable/equatable.dart';

abstract class LocalCategoriesEvent extends Equatable {
  const LocalCategoriesEvent();

  @override
  List<Object> get props => [];
}

class AddCategoriesEvent extends LocalCategoriesEvent {
  final Categories categories;
  const AddCategoriesEvent({required this.categories});

  @override
  List<Object> get props => [categories];
}
