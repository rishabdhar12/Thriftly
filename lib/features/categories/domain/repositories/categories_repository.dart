import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoriesRespository {
  Future<Either<Failure, Categories>> addCategory(Categories category);
  Future<Either<Failure, List<Categories>>> addCategories(
      List<Categories> categories);
  Future<Either<Failure, Categories>> getCategory(String name);
  Future<Either<Failure, List<Categories>>> getCategories();
  Future<Either<Failure, bool>> deleteCategories(String name);
  Future<Either<Failure, List<Categories>>> resetCategories();
}
