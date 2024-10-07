import 'package:budgeting_app/features/authentication/domain/entities/google_user_entity.dart';

class GoogleUserModel extends GoogleUserEntity {
  const GoogleUserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    required super.photoUrl,
  });
}
