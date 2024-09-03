import 'dart:developer';

import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/icon_data.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_bloc.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_event.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseHistoryScreen extends StatefulWidget {
  final int id;
  const ExpenseHistoryScreen({super.key, required this.id});

  @override
  State<ExpenseHistoryScreen> createState() => _ExpenseHistoryScreenState();
}

class _ExpenseHistoryScreenState extends State<ExpenseHistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<LocalTransactionBloc>(context)
        .add(GetTransactionEvent(categoryId: widget.id));
    super.initState();
  }

  void addTransaction(AddTransactionParams params) {
    BlocProvider.of<LocalTransactionBloc>(context)
        .add(AddTransactionEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: elevatedButton(
              width: 190,
              height: 45,
              onPressed: () async {
                final transaction = Transaction()
                  ..title = "three"
                  ..categoryId = widget.id;
                addTransaction(
                  AddTransactionParams(
                    transaction: transaction,
                    categoryId: widget.id,
                  ),
                );
              },
              textWidget: textWidget(
                text: AppStrings.addExpense,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: ColorCodes.appBackground,
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: BlocBuilder<LocalTransactionBloc, LocalTransactionState>(
              builder: (context, state) {
                if (state is LocalTransactionLoadingState) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 30,
                      color: ColorCodes.buttonColor,
                    ),
                  );
                }

                if (state is LocalTransactionErrorState) {
                  log(state.message);
                }

                if (state is LocalTransactionsFetchedState) {
                  final transactions = state.transactions;
                  if (transactions!.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: textWidget(
                          text:
                              "Looks like your wallet's been on vacation! 🏖️ \n\nNo transactions to show.",
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 40.0);
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                visualDensity:
                                    const VisualDensity(vertical: 4.0),
                                leading: Container(
                                  height: 90.0,
                                  width: 70.0,
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: ColorCodes.darkBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    IconData(appIconsMap['fastfood']!.codePoint,
                                        fontFamily: "MaterialIcons"),
                                    size: 40.0,
                                    color: ColorCodes.white,
                                  ),
                                ),
                                title: textWidget(
                                  text: transactions[index].title,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                subtitle: textWidget(
                                  text: transactions[index]
                                      .date
                                      .toString()
                                      .split(" ")
                                      .first,
                                  fontSize: 14.0,
                                  color: ColorCodes.lightBlue,
                                ),
                                trailing: textWidget(
                                  text:
                                      "-${transactions[index].amountSpent.toString()}",
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorCodes.yellow,
                                ),
                              );
                            }),
                        // const Spacer(),
                        const SizedBox(height: 40.0),

                        // const SizedBox(height: 30.0),
                      ],
                    );
                  }
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}


// TODO: Make add transaction dynamic, dry ui
