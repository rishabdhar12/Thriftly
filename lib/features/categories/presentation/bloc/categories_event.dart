import 'package:equatable/equatable.dart';

abstract class RemoteFirebaseConfigEvent extends Equatable {
  const RemoteFirebaseConfigEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends RemoteFirebaseConfigEvent {
  const GetCategories();

  @override
  List<Object> get props => [];
}
