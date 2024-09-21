import 'package:isar/isar.dart';

class DeleteTransactionParams {
  final Id transactionId;
  final int categoryId;

  DeleteTransactionParams({
    required this.transactionId,
    required this.categoryId,
  });
}
