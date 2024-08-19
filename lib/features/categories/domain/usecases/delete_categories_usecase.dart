import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteCategoriesUsecase extends BaseUsecase<bool, String> {
  final CategoriesRespository _categoriesRespository;

  DeleteCategoriesUsecase(this._categoriesRespository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await _categoriesRespository.deleteCategories(params);
  }
}
