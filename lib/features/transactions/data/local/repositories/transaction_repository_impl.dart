import 'dart:developer';

import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/dto/delete_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/dto/edit_transaction_dto.dart';
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
      category?.amountLeft = (category!.amount - category!.totalDeducted);

      await _isar.writeTxn(() async {
        await _isar.categories.put(category!);
      });

      return Right(id ?? 0);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> editTransaction(
      EditTransactionParams params) async {
    Categories? category;
    Transaction? transaction;
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
        transaction =
            await _isar.transactions.filter().idEqualTo(params.id).findFirst();
      });

      if (transaction == null) {
        return const Left(ServerFailure("transaction not found"));
      }

      // Revert
      category?.totalDeducted -= transaction!.amountSpent;
      category?.amountLeft = transaction!.amountSpent;

      transaction?.title = params.transaction.title;
      transaction?.date = params.transaction.date;
      transaction?.amountSpent = params.transaction.amountSpent;
      transaction?.message = params.transaction.message;

      category?.totalDeducted += params.transaction.amountSpent;
      category?.amountLeft = (category!.amount - category!.totalDeducted);

      await _isar.writeTxn(() async {
        await _isar.transactions.put(transaction!);
        await _isar.categories.put(category!);
      });

      return Right(transaction!.id);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTransaction(
      DeleteTransactionParams params) async {
    Categories? category;
    Transaction? transaction;
    try {
      await _isar.writeTxn(() async {
        category = await _isar.categories
            .filter()
            .idEqualTo(params.categoryId)
            .findFirst();
      });

      if (category == null) {
        return const Left(ServerFailure("category not found!"));
      }

      await _isar.writeTxn(() async {
        transaction = await _isar.transactions
            .filter()
            .idEqualTo(params.transactionId)
            .findFirst();
      });

      if (transaction == null) {
        return const Left(ServerFailure("transaction not found!"));
      }

      category?.txnHistory = [...?category?.txnHistory];
      category?.txnHistory.removeWhere((id) => id == params.transactionId);

      category?.totalDeducted -= transaction!.amountSpent;
      category?.amountLeft += transaction!.amountSpent;

      await _isar.writeTxn(() async {
        await _isar.categories.put(category!);
        await _isar.transactions.delete(params.transactionId);
      });

      return const Right(true);
    } catch (error) {
      log("here");
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
