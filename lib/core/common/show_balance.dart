import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ShowBalance extends StatefulWidget {
  const ShowBalance({super.key});

  @override
  State<ShowBalance> createState() => _ShowBalanceState();
}

double totalBalance = 3500.00;

class _ShowBalanceState extends State<ShowBalance> {
  calcTotalBalance(List<Categories>? categories) {
    if (categories!.isNotEmpty) {
      for (Categories category in categories) {
        totalBalance += category.amount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalCategoriesBloc, LocalCategoriesState>(
      builder: (context, state) {
        if (state is LocalCategoriesFetchedState) {
          final categories = state.categories;
          calcTotalBalance(categories);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(AssetStrings.incomeIcon),
                            const SizedBox(width: 4),
                            textWidget(text: "Total Balance", fontSize: 12.0),
                          ],
                        ),
                        const SizedBox(height: 2),
                        textWidget(
                          text: "${AppStrings.rupee} $totalBalance",
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: ColorCodes.yellow,
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: ColorCodes.white,
                      thickness: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(AssetStrings.expenseIcon),
                            const SizedBox(width: 4),
                            textWidget(text: "Total Expense", fontSize: 12.0),
                          ],
                        ),
                        const SizedBox(height: 2),
                        textWidget(
                          text: "-${AppStrings.rupee} 0.00",
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: ColorCodes.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: totalBalance - 2000.00,
                ),
                builder: (context, value, _) => LinearProgressIndicator(
                  minHeight: 10.0,
                  borderRadius: BorderRadius.circular(12.0),
                  backgroundColor: ColorCodes.darkGreen,
                  value: value / totalBalance,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(ColorCodes.white),
                ),
              ),
              const SizedBox(height: 4.0),
              textWidget(
                  text: "30% of your income, Looks Good", fontSize: 12.0),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
