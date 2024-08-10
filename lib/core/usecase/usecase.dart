import 'package:budgeting_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseUsecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
