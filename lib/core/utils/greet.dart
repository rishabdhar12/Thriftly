import 'package:budgeting_app/core/constants/strings.dart';

String greet() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour < 12) {
    return AppStrings.goodMorning;
  } else if (hour < 18) {
    return AppStrings.goodAfternoon;
  } else {
    return AppStrings.goodEvening;
  }
}
