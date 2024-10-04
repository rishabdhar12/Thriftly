import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/features/transactions/domain/entities/local/txn_schema_isar.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_bloc.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

TabController? tabController;

final List<TransactionsData> data =
    List.filled(12, TransactionsData('', 0.0, 0.0));

class _AnalysisScreenState extends State<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void addToList(List<Transaction> transactions) {
    for (int i = 0; i < 12; i++) {
      final month = DateFormat('MMMM').format(DateTime(0, i + 1));
      data[i] = TransactionsData(month.substring(0, 3), 0.0, 0.0);
    }

    for (Transaction transaction in transactions) {
      final monthIndex = transaction.date.month - 1;
      data[monthIndex].amountSpent += transaction.amountSpent;
      // data[monthIndex].budget = totalBalance;
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
                SfCartesianChart(
                    primaryXAxis: const CategoryAxis(
                      borderWidth: 0,
                      majorGridLines: MajorGridLines(width: 0),
                      majorTickLines: MajorTickLines(width: 0),
                      labelStyle: TextStyle(color: ColorCodes.offWhite),
                    ),
                    primaryYAxis: const NumericAxis(
                      borderWidth: 0,
                      majorGridLines:
                          MajorGridLines(color: ColorCodes.grey, width: 0.4),
                      majorTickLines: MajorTickLines(width: 0),
                      labelStyle: TextStyle(color: ColorCodes.offWhite),
                    ),
                    // Chart title
                    title: const ChartTitle(
                      text: 'Monthly expenditure',
                      textStyle: TextStyle(color: ColorCodes.yellow),
                    ),
                    // Enable legend
                    legend: const Legend(isVisible: false),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<TransactionsData, String>>[
                      ColumnSeries<TransactionsData, String>(
                        enableTooltip: false,
                        dataSource: data,
                        xValueMapper: (TransactionsData sales, _) =>
                            sales.month,
                        yValueMapper: (TransactionsData sales, _) =>
                            sales.amountSpent,
                        // name: 'Sales',
                        // // Enable data label
                        // dataLabelSettings:
                        //     const DataLabelSettings(isVisible: false)
                      ),
                      ColumnSeries<TransactionsData, String>(
                        enableTooltip: false,
                        dataSource: data,
                        xValueMapper: (TransactionsData sales, _) =>
                            sales.month,
                        yValueMapper: (TransactionsData sales, _) =>
                            sales.budget,
                        // name: 'Sales',
                        // // Enable data label
                        // dataLabelSettings:
                        //     const DataLabelSettings(isVisible: false)
                      ),
                    ]),
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}

class TransactionsData {
  TransactionsData(this.month, this.amountSpent, this.budget);

  final String month;
  double amountSpent;
  double budget;
}
