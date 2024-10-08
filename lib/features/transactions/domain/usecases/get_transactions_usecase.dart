import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTransactionsUsecase extends BaseUsecase<List<Transaction>, NoParams> {
  final TransactionRepository _transactionRepository;

  GetTransactionsUsecase(this._transactionRepository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    return await _transactionRepository.getTransactions();
  }
}
