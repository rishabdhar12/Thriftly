import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:fpdart/fpdart.dart';

abstract class TransactionRepository {
  Future<Either<Failure, Transaction>> addTransaction(Transaction transaction);
}
