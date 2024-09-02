import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
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

class _DataTableViewState extends State<DataTableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Table(
        columnWidths: {
          0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.50),
          1: FixedColumnWidth(MediaQuery.of(context).size.width * 0.25),
          2: FixedColumnWidth(MediaQuery.of(context).size.width * 0.25),
        },
        children: widget.categories!
            .where((category) => category.duration == widget.duration)
            .map((category) {
          return TableRow(
            children: [
              _buildCell(category.name,
                  icon:
                      IconData(category.iconCode, fontFamily: 'MaterialIcons')),
              _buildCell(category.amount.toString()),
              _buildCell(category.totalDeducted.toString()),
            ],
          );
        }).toList(),
      ),
    );
  }
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
                    height: 46.0,
                    width: 46.0,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: ColorCodes.lightBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      icon,
                      size: 30,
                      color: ColorCodes.white,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 14.0),
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
