import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginOrSignUp extends StatelessWidget {
  const LoginOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(AssetStrings.logoGreen),
            const SizedBox(height: 6),
            textWidget(
              text: AppStrings.appName,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: ColorCodes.lightGreen,
              letterSpacing: 2.0,
            ),
            textWidget(
              text: AppStrings.tagLine,
              color: ColorCodes.lightGreen,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            elevatedButton(
              width: 207,
              height: 45,
              onPressed: () {
                if (context.mounted) {
                  context.go(RouteNames.login);
                }
              },
              textWidget: textWidget(
                text: AppStrings.login,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorCodes.appBackground,
              ),
            ),
            const SizedBox(height: 10),
            elevatedButton(
              width: 207,
              height: 45,
              onPressed: () => {
                context.go(RouteNames.signUp),
              },
              buttonColor: ColorCodes.lightGreen,
              textWidget: textWidget(
                text: AppStrings.signUp,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: ColorCodes.appBackground,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: textWidget(
                text: AppStrings.forgotPassword,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorCodes.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
