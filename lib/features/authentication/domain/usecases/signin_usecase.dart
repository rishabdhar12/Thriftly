// lib/features/auth/domain/usecases/sign_in_with_phone_number.dart
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:fpdart/fpdart.dart';

class SignInWithPhoneNumber implements BaseUsecase<AuthEntity, String> {
  final AuthRepository repository;

  SignInWithPhoneNumber(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(String phoneNumber) async {
    return await repository.signInWithPhoneNumber(phoneNumber);
  }
}
