import 'package:flutter/cupertino.dart';

class CustomCupertinoDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const CustomCupertinoDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 252,
      color: CupertinoColors.white,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              onDateTimeChanged: onDateChanged,
            ),
          ),
          CupertinoButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
