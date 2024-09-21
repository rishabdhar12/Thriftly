import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/dto/delete_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:equatable/equatable.dart';

abstract class LocalTransactionState extends Equatable {
  final Categories? category;
  final Transaction? transaction;
  final List<Transaction>? transactions;
  final int? transactionId;

  const LocalTransactionState({
    this.category,
    this.transaction,
    this.transactions,
    this.transactionId,
  });

  @override
  List<Object> get props => [category!, transaction!];
}

class LocalTransactionInitialState extends LocalTransactionState {}

class LocalTransactionLoadingState extends LocalTransactionState {}

class LocalTransactionsFetchedState extends LocalTransactionState {
  const LocalTransactionsFetchedState(List<Transaction> transactions)
      : super(transactions: transactions);
}

class LocalTransactionFinishedState extends LocalTransactionState {
  LocalTransactionFinishedState(AddTransactionParams params)
      : super(transaction: params.transaction);
}

class LocalTransactionDeletedState extends LocalTransactionState {
  LocalTransactionDeletedState(DeleteTransactionParams params)
      : super(transactionId: params.transactionId);
}

class LocalTransactionErrorState extends LocalTransactionState {
  final String message;
  const LocalTransactionErrorState(this.message);
}
