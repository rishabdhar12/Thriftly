import 'package:budgeting_app/features/authentication/dto/signup_dto.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent({required this.verificationId, required this.otp});

  @override
  List<Object> get props => [verificationId, otp];
}

class GoogleSignInEvent extends AuthEvent {
  GoogleSignInEvent();

  @override
  List<Object> get props => [];
}

class CheckUserExistEvent extends AuthEvent {
  final String phoneNumber;

  CheckUserExistEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class SignUpEvent extends AuthEvent {
  final SignUpParams signUpParams;

  SignUpEvent({required this.signUpParams});

  @override
  List<Object> get props => [signUpParams];
}
