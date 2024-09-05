import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/utils/days_left_month.dart';
import 'package:budgeting_app/core/utils/days_left_week.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:flutter/material.dart';

class DataTableView extends StatefulWidget {
  final String duration;
  final List<Categories>? categories;
  const DataTableView(
      {super.key, required this.duration, required this.categories});

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

int daysRemainingMonth = 0;
int daysRemainingWeek = 0;

class _DataTableViewState extends State<DataTableView> {
  @override
  void initState() {
    daysRemainingMonth = daysLeftInCurrMonth();
    daysRemainingWeek = daysLeftInCurrWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.categories!
              .where((category) => category.duration == widget.duration)
              .toList()
              .isEmpty
          ? Center(
              // crossAxisAlignment: CrossAxisAlignment.center,
              child: textWidget(
                text: widget.duration == AppStrings.daily
                    ? AppStrings.nothingToShowToday
                    : widget.duration == AppStrings.weekly
                        ? AppStrings.nothingToShowWeekly
                        : AppStrings.nothingToShowMonth,
                color: ColorCodes.white,
                fontSize: 18.0,
                textAlign: TextAlign.center,
              ),
            )
          : Table(
              columnWidths: {
                0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.50),
                1: FixedColumnWidth(MediaQuery.of(context).size.width * 0.25),
                2: FixedColumnWidth(MediaQuery.of(context).size.width * 0.25),
              },
              children: [
                TableRow(
                  children: [
                    widget.duration == AppStrings.weekly
                        ? buildHeaderCell(
                            "Items ($daysRemainingWeek days left)")
                        : widget.duration == AppStrings.monthly
                            ? buildHeaderCell(
                                "Items ($daysRemainingMonth days left)")
                            : buildHeaderCell("Items"),
                    buildHeaderCell('Budget'),
                    buildHeaderCell('Left'),
                  ],
                ),
                ...widget.categories!
                    .where((category) => category.duration == widget.duration)
                    .toList()
                    .reversed
                    // .take(3)
                    .map((category) {
                  return TableRow(
                    children: [
                      _buildCell(category.name,
                          icon: IconData(category.iconCode,
                              fontFamily: 'MaterialIcons')),
                      _buildCell(category.amount.toString()),
                      _buildCell(category.amount < category.amountLeft
                          ? "-${category.amountLeft}"
                          : "${category.amountLeft}"),
                    ],
                  );
                }),
              ],
            ),
    );
  }
}

Widget buildHeaderCell(String text) {
  return Container(
    height: 50.0,
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    color: ColorCodes.appBackgroundWithTransparency,
    child: Center(
      child: textWidget(
        text: text,
        color: ColorCodes.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildCell(String text, {IconData? icon}) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        // color: Colors.amber,
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Container(
                    height: 40.0,
                    width: 40.0,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: ColorCodes.lightBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      icon,
                      size: 26,
                      color: ColorCodes.white,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 6.0),
            Flexible(
              child: textWidget(
                text: text,
                textAlign: TextAlign.start,
                color: ColorCodes.white,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
