import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class HomeEvent extends BottomNavigationEvent {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AnalysisEvent extends BottomNavigationEvent {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

class TransactionEvent extends BottomNavigationEvent {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class CategoriesTxnEvent extends BottomNavigationEvent {
  const CategoriesTxnEvent();

  @override
  List<Object> get props => [];
}

class ProfileEvent extends BottomNavigationEvent {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
