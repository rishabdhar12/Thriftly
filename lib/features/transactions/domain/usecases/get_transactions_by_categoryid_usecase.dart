import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTransactionsByCategoryIdUsecase
    extends BaseUsecase<List<Transaction>, int> {
  final TransactionRepository _transactionRepository;

  GetTransactionsByCategoryIdUsecase(this._transactionRepository);

  @override
  Future<Either<Failure, List<Transaction>>> call(int params) async {
    return await _transactionRepository.getTransactionsByCategoryId(params);
  }
}
