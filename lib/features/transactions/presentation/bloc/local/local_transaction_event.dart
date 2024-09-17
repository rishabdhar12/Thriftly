import 'package:budgeting_app/features/transactions/domain/dto/edit_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:equatable/equatable.dart';

abstract class LocalTransactionEvent extends Equatable {
  const LocalTransactionEvent();

  @override
  List<Object> get props => [];
}

class AddTransactionEvent extends LocalTransactionEvent {
  final AddTransactionParams params;
  const AddTransactionEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class EditTransactionEvent extends LocalTransactionEvent {
  final EditTransactionParams params;
  const EditTransactionEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class GetTransactionEvent extends LocalTransactionEvent {
  final int categoryId;
  const GetTransactionEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
