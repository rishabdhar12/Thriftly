import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> openIsarInstance() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [CategoriesSchema, TransactionSchema],
    directory: dir.path,
    inspector: true,
  );
}
