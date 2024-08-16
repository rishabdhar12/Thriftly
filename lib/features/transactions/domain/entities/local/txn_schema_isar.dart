import 'package:isar/isar.dart';

part 'txn_schema_isar.g.dart';

@Collection()
class Transaction {
  Id id = Isar.autoIncrement;
  double amountSpent = 0.00;
  DateTime date = DateTime.now();
  String message = "";
}
