import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCategoriesUsecase extends BaseUsecase<Categories, String> {
  final CategoriesRespository _categoriesRespository;

  GetCategoriesUsecase(this._categoriesRespository);

  @override
  Future<Either<Failure, Categories>> call(String params) async {
    return await _categoriesRespository.getCategory(params);
  }
}
