import 'dart:async';

import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/features/authentication/data/models/auth_model.dart';
import 'package:budgeting_app/features/authentication/data/models/google_user_model.dart';
import 'package:budgeting_app/features/authentication/domain/entities/user_entity.dart';
import 'package:budgeting_app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:budgeting_app/features/authentication/dto/signup_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthRepositoryImpl(
      this.firebaseAuth, this.firebaseFirestore, this.googleSignIn);

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

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      // final User currentUser = firebaseAuth.currentUser!;
      // log("$currentUser");
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
        // 'password': params.password,
        // 'confirm_password': params.confirmPassword,
      });

      final userEntity = UserEntity(
        fullName: params.fullName,
        phoneNumber: params.phoneNumber,
        email: params.email,
        dob: params.dob,
        // password: params.password,
        // confirmPassword: params.confirmPassword,
      );
      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GoogleUserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return const Left(Failure('User canceled Google sign in'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        final userModel = GoogleUserModel(
          uid: user.uid,
          email: user.email!,
          displayName: user.displayName!,
          photoUrl: user.photoURL!,
        );
        return Right(userModel);
      } else {
        return const Left(Failure('Google sign in failed'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
