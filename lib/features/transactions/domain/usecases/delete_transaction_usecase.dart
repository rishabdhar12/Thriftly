import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/dto/delete_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteTransactionUsecase
    extends BaseUsecase<bool, DeleteTransactionParams> {
  final TransactionRepository _transactionRepository;

  DeleteTransactionUsecase(this._transactionRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteTransactionParams params) async {
    return await _transactionRepository.deleteTransaction(params);
  }
}
