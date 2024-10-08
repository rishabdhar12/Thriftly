import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoriesUsecase
    extends BaseUsecase<List<Categories>, List<Categories>> {
  final CategoriesRespository _categoriesRespository;

  CategoriesUsecase(this._categoriesRespository);

  @override
  Future<Either<Failure, List<Categories>>> call(
      List<Categories> params) async {
    return await _categoriesRespository.addCategories(params);
  }
}
