import 'dart:async';

import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/authentication/data/models/auth_model.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<Either<Failure, AuthModel>> signInWithPhoneNumber(
      String phoneNumber) async {
    final completer = Completer<Either<Failure, AuthModel>>();
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final userCredential =
                await firebaseAuth.signInWithCredential(credential);
            final user = userCredential.user;
            if (user != null) {
              completer.complete(
                Right(AuthModel(uid: user.uid, phoneNumber: user.phoneNumber!)),
              );
            } else {
              completer.complete(const Left(ServerFailure('User is null')));
            }
          } catch (e) {
            completer.complete(Left(ServerFailure(e.toString())));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.complete(Left(ServerFailure(e.message!)));
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(
            Right(AuthModel(uid: verificationId, phoneNumber: phoneNumber)),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }

    return completer.future;
  }

  @override
  Future<Either<Failure, AuthModel>> verifyOtp(
      String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        return Right(AuthModel(uid: user.uid, phoneNumber: user.phoneNumber!));
      }
      return const Left(ServerFailure('Invalid OTP'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
