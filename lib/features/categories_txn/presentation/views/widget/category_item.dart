import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget categoryItem(BuildContext context, List<Categories> categories, int index) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      GestureDetector(
        onTap: () {
          context.push(
            RouteNames.expenseHistoryScreen,
            extra: {
              'id': categories[index].id,
              'iconCode': categories[index].iconCode,
              // '': categories[index].iconCode,
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: ColorCodes.lightBlue,
          ),
          child: GridTile(
            child: Icon(
              IconData(categories[index].iconCode, fontFamily: 'MaterialIcons'),
              size: 60,
              color: ColorCodes.white,
            ),
          ),
        ),
      ),
      const SizedBox(height: 4.0),
      textWidget(
        text: categories[index].name,
        fontSize: 12.0,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        color: ColorCodes.white,
      ),
    ],
  );
}
