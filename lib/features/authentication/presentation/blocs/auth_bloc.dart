import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/check_user_exists_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/google_signin_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:budgeting_app/features/authentication/domain/usecases/verifyotp_usecase.dart';
import 'package:budgeting_app/features/authentication/dto/verify_otp_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifyOtp verifyOtp;
  final CheckUserExist checkUserExist;
  final SignUp signUp;
  final GoogleSignInUsecase googleSignInUsecase;

  AuthBloc({
    required this.signInWithPhoneNumber,
    required this.verifyOtp,
    required this.checkUserExist,
    required this.signUp,
    required this.googleSignInUsecase,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<CheckUserExistEvent>(_onCheckUserExist);
    on<SignUpEvent>(_onSignUp);
    on<GoogleSignInEvent>(_onSignInWithGoogle);
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

  void _onCheckUserExist(
      CheckUserExistEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrUser = await checkUserExist(event.phoneNumber);
    failureOrUser.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(UserExistState(isUserExist: user)),
    );
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final signUpResponse = await signUp(event.signUpParams);

      if (signUpResponse.isLeft()) {
        final failure = signUpResponse.getLeft().toNullable();
        emit(AuthError(message: failure?.message ?? "Unknown error"));
        return;
      }

      final signUpWithPhoneNumberResponse =
          await signInWithPhoneNumber(event.signUpParams.phoneNumber);

      if (signUpWithPhoneNumberResponse.isLeft()) {
        final failure = signUpWithPhoneNumberResponse.getLeft().toNullable();
        emit(AuthError(message: failure?.message ?? "Unknown error"));
        return;
      }

      final user = signUpWithPhoneNumberResponse.getRight().toNullable();
      // log("AuthBloc: ${user!.uid}");
      emit(OtpSentState(verificationId: user!.uid));
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }

  void _onSignInWithGoogle(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final signInResponse = await googleSignInUsecase(NoParams());

      signInResponse.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(GoogleAuthenticatedState(user: user)),
      );
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }
}
