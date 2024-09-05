int daysLeftInCurrMonth() {
  DateTime now = DateTime.now();
  final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
  final daysRemaining = lastDayOfMonth - now.day;
  return daysRemaining;
}
