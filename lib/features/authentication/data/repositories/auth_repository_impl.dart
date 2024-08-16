import 'dart:async';
import 'dart:developer';

import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/authentication/data/models/auth_model.dart';
import 'package:budgeting_app/features/authentication/domain/entities/user_entity.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/dto/signup_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepositoryImpl(this.firebaseAuth, this.firebaseFirestore);

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

  @override
  Future<Either<Failure, bool>> checkUserExists(String phoneNumber) async {
    log(phoneNumber);
    log("1");
    try {
      final user = await firebaseFirestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      if (user.docs.isNotEmpty) {
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signup(SignUpParams params) async {
    try {
      await firebaseFirestore.collection('users').add({
        'fullName': params.fullName,
        'phoneNumber': params.phoneNumber,
        'email': params.email,
        'dob': params.dob,
      });

      final userEntity = UserEntity(
        fullName: params.fullName,
        phoneNumber: params.phoneNumber,
        email: params.email,
        dob: params.dob,
      );
      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
