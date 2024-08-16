import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:fpdart/fpdart.dart';

class CheckUserExist implements BaseUsecase<bool, String> {
  final AuthRepository repository;

  CheckUserExist(this.repository);

  @override
  Future<Either<Failure, bool>> call(String phoneNumber) async {
    return await repository.checkUserExists(phoneNumber);
  }
}
