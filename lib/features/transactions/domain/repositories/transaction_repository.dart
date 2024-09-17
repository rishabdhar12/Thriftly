import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/transactions/domain/dto/edit_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:fpdart/fpdart.dart';

abstract class TransactionRepository {
  Future<Either<Failure, int>> addTransaction(AddTransactionParams params);
  Future<Either<Failure, int>> editTransaction(EditTransactionParams params);
  Future<Either<Failure, List<Transaction>>> getTransactions(int categoryId);
}
