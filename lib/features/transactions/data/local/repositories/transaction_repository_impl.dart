import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Isar _isar;

  const TransactionRepositoryImpl(this._isar);

  @override
  Future<Either<Failure, Transaction>> addTransaction(
      Transaction transaction) async {
    Id? id;
    Categories? category;
    try {
      await _isar.writeTxn(() async {
        category = await _isar.categories
            .filter()
            .idEqualTo(transaction.categoryId)
            .findFirst();
      });

      if (category == null) {
        return const Left(ServerFailure("category not found"));
      }

      await _isar.writeTxn(() async {
        id = await _isar.transactions.put(transaction);
      });

      if (id == null) {
        return const Left(ServerFailure("unable to edit categories schema"));
      }

      category?.txnHistory = [...category!.txnHistory, id!];
      await _isar.writeTxn(() async {
        await _isar.categories.put(category!);
      });

      return Right(transaction);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
