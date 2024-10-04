import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

class CategoriesRepositoriesImpl implements CategoriesRespository {
  final Isar _isar;

  const CategoriesRepositoriesImpl(this._isar);

  @override
  Future<Either<Failure, Categories>> addCategory(Categories category) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.categories.put(category);
      });
      return Right(category);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Categories>>> addCategories(
      List<Categories> categories) async {
    try {
      await _isar.writeTxn(() async {
        for (Categories category in categories) {
          await _isar.categories.put(category);
        }
      });
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Categories>> getCategory(String name) async {
    Categories? category;
    try {
      await _isar.writeTxn(() async {
        category =
            await _isar.categories.filter().nameEqualTo(name).findFirst();
      });

      return Right(category!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    List<Categories>? categories;
    try {
      await _isar.writeTxn(() async {
        categories = await _isar.categories.where().findAll();
      });

      return Right(categories!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(int categoryId) async {
    bool result = false;

    try {
      await _isar.writeTxn(() async {
        result = await _isar.categories.delete(categoryId);
      });

      if (result) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Categories>>> resetCategories() async {
    List<Categories>? categories;
    try {
      await _isar.writeTxn(() async {
        categories = await _isar.categories.where().findAll();
      });

      final currentDate = DateTime.now();

      for (var category in categories!) {
        bool shouldReset = false;

        switch (category.duration) {
          case AppStrings.monthly:
            shouldReset = currentDate.day == 1;
            break;
          case AppStrings.weekly:
            shouldReset = currentDate.weekday == DateTime.monday;
            break;
          case AppStrings.daily:
            shouldReset = currentDate != category.stateDate;
            break;
          default:
            break;
        }

        if (shouldReset) {
          category.amountLeft = category.amount;
          category.totalDeducted = 0.00;

          await _isar.writeTxn(() async {
            await _isar.categories.put(category);
          });
        }
      }

      return Right(categories!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
