import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Isar _isar;

  const TransactionRepositoryImpl(this._isar);

  @override
  Future<Either<Failure, int>> addTransaction(
      AddTransactionParams params) async {
    Id? id;
    Categories? category;
    try {
      await _isar.writeTxn(() async {
        category = await _isar.categories
            .filter()
            .idEqualTo(params.categoryId)
            .findFirst();
      });

      if (category == null) {
        return const Left(ServerFailure("category not found"));
      }

      await _isar.writeTxn(() async {
        id = await _isar.transactions.put(params.transaction);
      });

      if (id == null) {
        return const Left(ServerFailure("unable to edit categories schema"));
      }

      category?.txnHistory = [...category!.txnHistory, id!];
      category?.totalDeducted += params.transaction.amountSpent;
      category?.amountLeft =
          (category!.amount - params.transaction.amountSpent);

      await _isar.writeTxn(() async {
        await _isar.categories.put(category!);
      });

      return Right(id ?? 0);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(
      int categoryId) async {
    List<Transaction>? transactions;
    try {
      await _isar.writeTxn(() async {
        transactions = await _isar.transactions
            .filter()
            .categoryIdEqualTo(categoryId)
            .findAll();
      });
      return Right(transactions ?? []);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
