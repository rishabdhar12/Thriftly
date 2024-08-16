import 'package:budgeting_app/features/categories/domain/entities/categories_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteCategoriesState extends Equatable {
  final List<CategoriesEntity>? categoriesEntity;

  const RemoteCategoriesState({this.categoriesEntity});

  @override
  List<Object> get props => [categoriesEntity!];
}

class RemoteCategoriesInitialState extends RemoteCategoriesState {}

class RemoteCategoriesLoadingState extends RemoteCategoriesState {}

class RemoteCategoriesFinishedState extends RemoteCategoriesState {
  const RemoteCategoriesFinishedState(List<CategoriesEntity> categoriesEntity)
      : super(categoriesEntity: categoriesEntity);
}

class RemoteCategoriesErrorState extends RemoteCategoriesState {
  final String message;

  const RemoteCategoriesErrorState(this.message);
}
