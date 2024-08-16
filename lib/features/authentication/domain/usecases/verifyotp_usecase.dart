import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/dto/verify_otp_dto.dart';
import 'package:fpdart/fpdart.dart';

class VerifyOtp implements BaseUsecase<AuthEntity, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.verificationId, params.otp);
  }
}
