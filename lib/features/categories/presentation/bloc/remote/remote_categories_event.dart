import 'package:equatable/equatable.dart';

abstract class RemoteCategoriesEvent extends Equatable {
  const RemoteCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends RemoteCategoriesEvent {
  const GetCategories();

  @override
  List<Object> get props => [];
}
