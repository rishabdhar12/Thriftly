import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RevenueCard extends StatefulWidget {
  const RevenueCard({super.key});

  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: ColorCodes.buttonColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: 1,
                ),
                builder: (context, value, _) => CircularPercentIndicator(
                  radius: 34.0,
                  lineWidth: 5.0,
                  percent: 0.6,
                  center: const Text("100%"),
                  progressColor: ColorCodes.darkBlue,
                ),
              ),
              const SizedBox(height: 8.0),
              textWidget(
                text: AppStrings.savingsOnGoals,
                fontSize: 10.0,
                color: ColorCodes.appBackground,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: VerticalDivider(
              color: ColorCodes.white,
              thickness: 2,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRevenueInfo(
                    "${AppStrings.revenueDuration} Week", "40000.00"),
                const SizedBox(height: 8.0),
                const Divider(color: ColorCodes.white, thickness: 2),
                const SizedBox(height: 8.0),
                _buildRevenueInfo(
                    "${AppStrings.savingsDuration} Week", "40000.00"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRevenueInfo(String title, String amount) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetStrings.revenueIcon,
          height: 28.0,
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
              text: title,
              color: ColorCodes.appBackground,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
            textWidget(
              text: amount,
              color: ColorCodes.appBackground,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ],
    );
  }
}
