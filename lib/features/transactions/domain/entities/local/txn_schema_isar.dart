import 'package:isar/isar.dart';

part 'txn_schema_isar.g.dart';

@collection
class Transaction {
  Id id = Isar.autoIncrement;
  late int categoryId;
  String title = "";
  double totalBudget = 0.00;
  double amountSpent = 0.00;
  DateTime date = DateTime.now();
  int month = DateTime.now().month;
  late int weekNumber;
  int year = DateTime.now().year;
  String message = "";

  Transaction() {
    weekNumber = _calculateWeekNumber(date);
  }

  int _calculateWeekNumber(DateTime date) {
    int dayOfMonth = date.day;
    int weekNumber = ((dayOfMonth - 1) ~/ 7) + 1;
    return weekNumber;
  }
}
