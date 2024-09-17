import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:isar/isar.dart';

class EditTransactionParams {
  final Id id;
  final int categoryId;
  final Transaction transaction;

  EditTransactionParams({
    required this.id,
    required this.categoryId,
    required this.transaction,
  });
}
