import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

class CategoriesRepositoriesImpl implements CategoriesRespository {
  final Isar _isar;

  const CategoriesRepositoriesImpl(this._isar);

  @override
  Future<Either<Failure, Categories>> addCategories(
      Categories categories) async {
    try {
      await _isar.writeTxn(() async {
        _isar.categories.put(categories);
      });
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
