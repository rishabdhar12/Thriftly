int daysLeftInCurrWeek() {
  DateTime now = DateTime.now();
  final daysRemaining = 7 - now.weekday;
  return daysRemaining;
}
