import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddTransactionUsecase extends BaseUsecase<int, AddTransactionParams> {
  final TransactionRepository _transactionRepository;

  AddTransactionUsecase(this._transactionRepository);

  @override
  Future<Either<Failure, int>> call(AddTransactionParams params) async {
    return await _transactionRepository.addTransaction(params);
  }
}
