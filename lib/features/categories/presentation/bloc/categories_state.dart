import 'package:budgeting_app/features/categories/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteFirebaseConfigState extends Equatable {
  final List<CategoriesEntity>? categoriesEntity;

  const RemoteFirebaseConfigState({this.categoriesEntity});

  @override
  List<Object> get props => [categoriesEntity!];
}

class RemoteFirebaseConfigInitialState extends RemoteFirebaseConfigState {}

class RemoteFirebaseConfigLoadingState extends RemoteFirebaseConfigState {}

class RemoteFirebaseConfigFinishedState extends RemoteFirebaseConfigState {
  const RemoteFirebaseConfigFinishedState(
      List<CategoriesEntity> categoriesEntity)
      : super(categoriesEntity: categoriesEntity);
}

class RemoteFirebaseConfigErrorState extends RemoteFirebaseConfigState {
  final String message;

  const RemoteFirebaseConfigErrorState(this.message);
}
