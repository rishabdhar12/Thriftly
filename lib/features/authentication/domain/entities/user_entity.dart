import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String dob;
  // final String password;
  // final String confirmPassword;

  const UserEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.dob,
    // required this.password,
    // required this.confirmPassword,
  });

  @override
  List<Object> get props => [
        fullName,
        phoneNumber,
        email,
        dob,
        // password,
        // confirmPassword,
      ];
}
