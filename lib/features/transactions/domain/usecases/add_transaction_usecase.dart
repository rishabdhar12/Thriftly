import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddTransactionUsecase extends BaseUsecase<Transaction, Transaction> {
  final TransactionRepository _transactionRepository;

  AddTransactionUsecase(this._transactionRepository);

  @override
  Future<Either<Failure, Transaction>> call(Transaction params) async {
    return await _transactionRepository.addTransaction(params);
  }
}
