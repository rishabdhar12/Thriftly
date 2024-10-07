import 'package:budgeting_app/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.fullName,
    required super.phoneNumber,
    required super.email,
    required super.dob,
    // required super.password,
    // required super.confirmPassword,
  });
}
