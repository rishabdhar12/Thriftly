import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future datePicker(
  BuildContext context, {
  required TextEditingController dateController,
  required DateTime selectedDate,
}) async {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final DateTime now = DateTime.now();
  final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  final DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: firstDayOfMonth,
    lastDate: lastDayOfMonth,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );

  if (pickedDate != null && pickedDate != selectedDate) {
    selectedDate = pickedDate;
    dateController.text = formatter.format(selectedDate);
  }
}
