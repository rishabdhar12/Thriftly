// lib/features/auth/presentation/bloc/auth_bloc.dart
import 'package:budgeting_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/verifyotp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifyOtp verifyOtp;

  AuthBloc({
    required this.signInWithPhoneNumber,
    required this.verifyOtp,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
  }

  void _onSendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrUser = await signInWithPhoneNumber(event.phoneNumber);
    failureOrUser.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(OtpSentState(verificationId: user.uid)),
    );
  }

  void _onVerifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrUser = await verifyOtp(
      VerifyOtpParams(
        event.verificationId,
        event.otp,
      ),
    );
    failureOrUser.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthenticatedState(user: user)),
    );
  }
}