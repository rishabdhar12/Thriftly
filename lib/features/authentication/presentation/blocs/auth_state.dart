import 'package:budgeting_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class OtpSentState extends AuthState {
  final String verificationId;

  OtpSentState({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}

class AuthLoading extends AuthState {}

class AuthenticatedState extends AuthState {
  final AuthEntity user;

  AuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserExistState extends AuthState {
  final bool isUserExist;

  UserExistState({required this.isUserExist});

  @override
  List<Object> get props => [isUserExist];
}
