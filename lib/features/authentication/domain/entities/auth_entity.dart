import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String uid;
  final String phoneNumber;

  const AuthEntity({
    required this.uid,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [uid, phoneNumber];
}
