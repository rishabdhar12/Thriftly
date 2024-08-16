import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String dob;

  const UserEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.dob,
  });

  @override
  List<Object> get props => [fullName, phoneNumber, email, dob];
}
