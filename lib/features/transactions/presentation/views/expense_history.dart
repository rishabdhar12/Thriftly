import 'dart:developer';

import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/utils/snackbar.dart';
import 'package:budgeting_app/features/transactions/domain/dto/delete_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/dto/edit_transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/dto/transaction_dto.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_bloc.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_event.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ExpenseHistoryScreen extends StatefulWidget {
  final int id;
  final int iconCode;
  const ExpenseHistoryScreen({
    super.key,
    required this.id,
    required this.iconCode,
  });

  @override
  State<ExpenseHistoryScreen> createState() => _ExpenseHistoryScreenState();
}

DateTime _selectedDate = DateTime.now();
String _selectedDateFormatted =
    DateFormat("dd/MM/yyyy").format(_selectedDate).toString();

final TextEditingController _titleController = TextEditingController(text: "");
final TextEditingController _messageController =
    TextEditingController(text: "");
final TextEditingController _amountController = TextEditingController(text: "");
final TextEditingController _dateController =
    TextEditingController(text: _selectedDateFormatted);

int transactionId = 0;

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

  void editTransaction(EditTransactionParams params) {
    BlocProvider.of<LocalTransactionBloc>(context)
        .add(EditTransactionEvent(params: params));
  }

  void deleteTransaction(DeleteTransactionParams params) {
    BlocProvider.of<LocalTransactionBloc>(context)
        .add(DeleteTransactionEvent(params: params));
  }

  submit() async {
    if (_titleController.text.isEmpty) {
      context.pop();
      showSnackBar(context, message: "title is mandatory");
    } else if (_amountController.text.isEmpty) {
      context.pop();
      showSnackBar(context, message: "amount is mandatory");
    } else if (_dateController.text.isEmpty) {
      context.pop();
      showSnackBar(context, message: "date is mandatory");
    } else {
      context.pop();
      final transaction = Transaction()
        ..categoryId = widget.id
        ..title = _titleController.text
        ..date = _selectedDate
        ..amountSpent = double.parse(_amountController.text)
        ..message = _messageController.text;
      addTransaction(
        AddTransactionParams(
          transaction: transaction,
          categoryId: widget.id,
        ),
      );
      _titleController.clear();
      _amountController.clear();
      _dateController.clear();
      _messageController.clear();
      showSnackBar(context, message: "Expense added successfully");
    }
  }

  edit() async {
    if (_titleController.text.isEmpty) {
      context.pop();
      showSnackBar(context, message: "title is mandatory");
    } else if (_amountController.text.isEmpty) {
      context.pop();
      showSnackBar(context, message: "amount is mandatory");
    } else if (_dateController.text.isEmpty) {
      context.pop();
      showSnackBar(context, message: "date is mandatory");
    } else {
      context.pop();
      final transaction = Transaction()
        ..categoryId = widget.id
        ..title = _titleController.text
        ..date = _selectedDate
        ..amountSpent = double.parse(_amountController.text)
        ..message = _messageController.text;
      editTransaction(
        EditTransactionParams(
          transaction: transaction,
          categoryId: widget.id,
          id: transactionId,
        ),
      );
      // deleteTransaction(
      //   DeleteTransactionParams(
      //     transactionId: transactionId,
      //     categoryId: widget.id,
      //   ),
      // );

      log(transactionId.toString());
      _titleController.clear();
      _amountController.clear();
      _dateController.clear();
      _messageController.clear();
      showSnackBar(context, message: "Expense added successfully");
    }
  }

  void _showDatePicker() async {
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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = formatter.format(_selectedDate);
      });
    }
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
                showExpenseBottomSheet(context);
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
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
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
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: textWidget(
                          text: AppStrings.noTransactions,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.filter_list,
                              color: ColorCodes.buttonColor,
                              size: 39.0,
                            ),
                          ),
                        ),
                        ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 20.0);
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    transactionId = transactions[index].id;
                                    await showEditBottomSheet(
                                        context, transactions[index]);
                                  },
                                  child: transactionItem(transactions, index));
                            }),
                        const SizedBox(height: 40.0),
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

  Future<void> showEditBottomSheet(
      BuildContext context, Transaction transaction) {
    _titleController.text = transaction.title;
    _amountController.text = transaction.amountSpent.toString();
    _messageController.text = transaction.message;
    _dateController.text = DateFormat("dd/MM/yyyy").format(transaction.date);

    return showModalBottomSheet(
      context: context,
      constraints: BoxConstraints.loose(
        Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.85,
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          decoration: const BoxDecoration(
            color: ColorCodes.appBackgroundWithTransparency,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: ListView(
            children: <Widget>[
              textWidget(
                text: AppStrings.editTransaction,
                fontSize: 24,
                color: ColorCodes.yellow,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 22),
              textWidget(
                text: AppStrings.expenseTitle,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 4),
              textFormField(
                hintText: AppStrings.expenseText,
                controller: _titleController,
                textInputType: TextInputType.text,
                contentPaddingVertical: 0.0,
              ),
              const SizedBox(height: 20),
              textWidget(
                text: AppStrings.enterDate,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorCodes.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: _dateController.text == ""
                          ? "DD/MM/YYYY"
                          : _dateController.text,
                      fontSize: 16,
                      color: ColorCodes.appBackground,
                    ),
                    CupertinoButton(
                      onPressed: _showDatePicker,
                      child: const Icon(CupertinoIcons.calendar),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              textWidget(
                text: AppStrings.enterAmount,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 4),
              textFormField(
                hintText: AppStrings.amountFormText,
                controller: _amountController,
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
                contentPaddingVertical: 0.0,
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 4),
              textFormField(
                hintText: AppStrings.message,
                controller: _messageController,
                textInputType: TextInputType.text,
                // contentPaddingVertical: 0.0,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              BlocBuilder<LocalTransactionBloc, LocalTransactionState>(
                builder: (context, state) {
                  if (state is LocalTransactionLoadingState) {
                    return const CupertinoActivityIndicator(
                      color: ColorCodes.buttonColor,
                      radius: 30,
                    );
                  }
                  return elevatedButton(
                    width: 190,
                    height: 45,
                    onPressed: () async {
                      await edit();
                    },
                    textWidget: textWidget(
                      text: AppStrings.submit,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ColorCodes.appBackground,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showExpenseBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      constraints: BoxConstraints.loose(
        Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.85,
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          decoration: const BoxDecoration(
            color: ColorCodes.appBackgroundWithTransparency,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              textWidget(
                text: AppStrings.expenseTitle,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 4),
              textFormField(
                hintText: AppStrings.expenseText,
                controller: _titleController,
                textInputType: TextInputType.text,
                contentPaddingVertical: 0.0,
              ),
              const SizedBox(height: 20),
              textWidget(
                text: AppStrings.enterDate,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorCodes.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: _dateController.text == ""
                          ? "DD/MM/YYYY"
                          : _dateController.text,
                      fontSize: 16,
                      color: ColorCodes.appBackground,
                    ),
                    CupertinoButton(
                      onPressed: _showDatePicker,
                      child: const Icon(CupertinoIcons.calendar),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              textWidget(
                text: AppStrings.enterAmount,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 4),
              textFormField(
                hintText: AppStrings.amountFormText,
                controller: _amountController,
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
                contentPaddingVertical: 0.0,
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 4),
              textFormField(
                hintText: AppStrings.message,
                controller: _messageController,
                textInputType: TextInputType.text,
                // contentPaddingVertical: 0.0,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              BlocBuilder<LocalTransactionBloc, LocalTransactionState>(
                builder: (context, state) {
                  if (state is LocalTransactionLoadingState) {
                    return const CupertinoActivityIndicator(
                      color: ColorCodes.buttonColor,
                      radius: 30,
                    );
                  }
                  return elevatedButton(
                    width: 190,
                    height: 45,
                    onPressed: () async {
                      await submit();
                    },
                    textWidget: textWidget(
                      text: AppStrings.submit,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ColorCodes.appBackground,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget transactionItem(List<Transaction> transactions, int index) {
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
          IconData(widget.iconCode, fontFamily: "MaterialIcons"),
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
}
