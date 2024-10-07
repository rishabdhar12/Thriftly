import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/authentication/domain/entities/google_user_entity.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:fpdart/fpdart.dart';

class GoogleSignInUsecase implements BaseUsecase<GoogleUserEntity, NoParams> {
  final AuthRepository repository;

  GoogleSignInUsecase(this.repository);

  @override
  Future<Either<Failure, GoogleUserEntity>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}
