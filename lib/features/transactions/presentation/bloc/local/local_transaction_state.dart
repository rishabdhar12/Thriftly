import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:equatable/equatable.dart';

abstract class LocalTransactionState extends Equatable {
  final Categories? category;
  final Transaction? transaction;

  const LocalTransactionState({this.category, this.transaction});

  @override
  List<Object> get props => [category!, transaction!];
}

class LocalTransactionInitialState extends LocalTransactionState {}

class LocalTransactionLoadingState extends LocalTransactionState {}

class LocalTransactionFinishedState extends LocalTransactionState {
  const LocalTransactionFinishedState(Transaction transaction)
      : super(transaction: transaction);
}

class LocalTransactionErrorState extends LocalTransactionState {
  final String message;
  const LocalTransactionErrorState(this.message);
}
