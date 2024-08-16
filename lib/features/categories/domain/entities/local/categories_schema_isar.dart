import 'package:isar/isar.dart';

part 'categories_schema_isar.g.dart';

@Collection()
class Categories {
  Id id = Isar.autoIncrement;
  String name = "";
  String desc = "";
  double amount = 0.00;
  String duration = "Monthly";
  List<Id> txnHistory = [];
  double totalDeducted = 0.00;
  double amountLeft = 0.00;
  DateTime stateDate = DateTime.now();
}
