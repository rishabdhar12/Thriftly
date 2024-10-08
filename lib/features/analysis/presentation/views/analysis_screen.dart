import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/features/analysis/presentation/widgets/cartesian_chart.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_bloc.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AnalysisScreen extends StatefulWidget {
  final double totalBudget;
  const AnalysisScreen({super.key, required this.totalBudget});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

TabController? tabController;

final List<TransactionsData> data = List.filled(12, TransactionsData('', 0.0));
// double totalBudget = 0.00;

class _AnalysisScreenState extends State<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void addToList(List<Transaction> transactions) {
    // totalBudget = transactions.first.totalBudget;
    for (int i = 0; i < 12; i++) {
      final month = DateFormat('MMMM').format(DateTime(0, i + 1));
      data[i] = TransactionsData(month.substring(0, 3), 0.0);
    }

    for (Transaction transaction in transactions) {
      final monthIndex = transaction.date.month - 1;
      data[monthIndex].amountSpent += transaction.amountSpent;
      // data[monthIndex].budget = transaction.totalBudget;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<LocalTransactionBloc, LocalTransactionState>(
            builder: (context, state) {
          if (state is LocalTransactionLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 30.0,
                color: ColorCodes.buttonColor,
              ),
            );
          }

          if (state is LocalTransactionsFetchedState) {
            addToList(state.transactions!);

            return Column(
              children: <Widget>[
                const SizedBox(height: 40),
                // Monthly vs Budget
                CartesianChart(totalBudget: widget.totalBudget),
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
