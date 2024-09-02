import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:equatable/equatable.dart';

abstract class LocalTransactionEvent extends Equatable {
  const LocalTransactionEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionEvent extends LocalTransactionEvent {
  final Transaction transaction;
  const AddTransactionEvent({required this.transaction});

  @override
  List<Object> get props => [transaction];
}
