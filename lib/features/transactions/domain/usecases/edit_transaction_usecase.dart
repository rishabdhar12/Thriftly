import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/dto/edit_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class EditTransactionUsecase extends BaseUsecase<int, EditTransactionParams> {
  final TransactionRepository _transactionRepository;

  EditTransactionUsecase(this._transactionRepository);

  @override
  Future<Either<Failure, int>> call(EditTransactionParams params) async {
    return await _transactionRepository.editTransaction(params);
  }
}
