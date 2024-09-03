import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';

class AddTransactionParams {
  final Transaction transaction;
  final int categoryId;

  AddTransactionParams({
    required this.transaction,
    required this.categoryId,
  });
}
