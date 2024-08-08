import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigate(context);
    super.initState();
  }

  void _navigate(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      context.replace("/${RouteNames.onboarding}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.splashBackground,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(AssetStrings.logo),
            text(
              text: AppStrings.appName,
              fontSize: 50,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
