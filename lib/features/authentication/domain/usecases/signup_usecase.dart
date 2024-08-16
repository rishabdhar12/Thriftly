import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/authentication/domain/entities/user_entity.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/dto/signup_dto.dart';
import 'package:fpdart/fpdart.dart';

class SignUp implements BaseUsecase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signup(params);
  }
}
