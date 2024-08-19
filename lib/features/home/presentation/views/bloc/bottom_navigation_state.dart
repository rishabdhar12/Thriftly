import 'package:equatable/equatable.dart';

abstract class BottomNavigationState extends Equatable {
  final int index = 0;
  const BottomNavigationState();

  @override
  List<Object> get props => [index];
}

class HomeState extends BottomNavigationState {
  const HomeState();

  @override
  final int index = 0;
  final String title = "Home";

  @override
  List<Object> get props => [index, title];
}

class AnalysisState extends BottomNavigationState {
  const AnalysisState();

  @override
  final int index = 1;
  final String title = "Analysis";

  @override
  List<Object> get props => [index, title];
}

class TransactionState extends BottomNavigationState {
  const TransactionState();

  @override
  final int index = 2;
  final String title = "Transaction";

  @override
  List<Object> get props => [index, title];
}

class CategoriesTxnState extends BottomNavigationState {
  const CategoriesTxnState();

  @override
  final int index = 3;
  final String title = "CategoriesTxn";

  @override
  List<Object> get props => [index, title];
}

class ProfileState extends BottomNavigationState {
  const ProfileState();

  @override
  final int index = 4;
  final String title = "Profile";

  @override
  List<Object> get props => [index, title];
}
