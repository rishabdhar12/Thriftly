import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/features/analysis/presentation/views/analysis_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CartesianChart extends StatelessWidget {
  final double totalBudget;
  const CartesianChart({
    super.key,
    required this.totalBudget,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        borderWidth: 0,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        labelStyle: TextStyle(color: ColorCodes.offWhite),
      ),
      primaryYAxis: NumericAxis(
        borderWidth: 0,
        majorGridLines:
            const MajorGridLines(color: ColorCodes.grey, width: 0.4),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(color: ColorCodes.offWhite),
        maximum: totalBudget,
        interval: totalBudget <= 1000
            ? 200
            : totalBudget <= 3000
                ? 500
                : 1000,
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
          xValueMapper: (TransactionsData transactionData, _) =>
              transactionData.month,
          yValueMapper: (TransactionsData transactionData, _) =>
              transactionData.amountSpent,
        ),
      ],
    );
  }
}

class TransactionsData {
  final String month;
  double amountSpent;
  // double budget;

  TransactionsData(this.month, this.amountSpent);
  // , this.budget
}
