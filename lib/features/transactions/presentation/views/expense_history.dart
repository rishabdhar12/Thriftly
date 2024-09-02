import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_bloc.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseHistoryScreen extends StatefulWidget {
  final int id;
  const ExpenseHistoryScreen({super.key, required this.id});

  @override
  State<ExpenseHistoryScreen> createState() => _ExpenseHistoryScreenState();
}

class _ExpenseHistoryScreenState extends State<ExpenseHistoryScreen> {
  void addTransaction(Transaction transaction) {
    BlocProvider.of<LocalTransactionBloc>(context)
        .add(AddTransactionEvent(transaction: transaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: elevatedButton(
          width: 190,
          height: 45,
          onPressed: () async {
            final transaction = Transaction()..categoryId = widget.id;
            addTransaction(transaction);
          },
          textWidget: textWidget(
            text: AppStrings.addExpense,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorCodes.appBackground,
          ),
        ),
      ),
    );
  }
}
