import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 90.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          text(
            text: AppStrings.welcomeText,
            fontSize: 44,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 30),
          Image.asset(AssetStrings.onboardingOne),
        ],
      ),
    );
  }
}
