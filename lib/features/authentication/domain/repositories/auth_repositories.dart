import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signInWithPhoneNumber(String phoneNumber);
  Future<Either<Failure, AuthEntity>> verifyOtp(
      String verificationId, String otp);
  Future<Either<Failure, bool>> checkUserExists(String phoneNumber);
}
