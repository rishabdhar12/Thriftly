import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget transactionItem(
    List<Transaction> transactions, int index, int iconCode) {
  return ListTile(
    visualDensity: const VisualDensity(vertical: 4.0),
    leading: Container(
      height: 60.0,
      width: 60.0,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: ColorCodes.darkBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Icon(
        IconData(iconCode, fontFamily: "MaterialIcons"),
        size: 36.0,
        color: ColorCodes.white,
      ),
    ),
    title: textWidget(
      text: transactions[index].title,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    subtitle: textWidget(
      text: DateFormat("dd/MM/yyyy")
          .format(transactions[index].date)
          .toString()
          .split(" ")
          .first,
      fontSize: 14.0,
      color: ColorCodes.lightBlue,
    ),
    trailing: textWidget(
      text: "-${transactions[index].amountSpent.toString()}",
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: ColorCodes.yellow,
    ),
  );
}
