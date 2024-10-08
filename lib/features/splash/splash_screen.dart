import 'dart:async';

import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/config/shared_prefs/keys.dart';
import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _navigate(context);
  }

  void _navigate(BuildContext context) async {
    final isLoggedIn = await PreferenceHelper.getDataFromSharedPreference(
            key: PrefsKeys.isLoggedIn) ??
        false;

    final isCategoriesSeen = await PreferenceHelper.getDataFromSharedPreference(
            key: PrefsKeys.isCategoriesSeen) ??
        false;
    _timer = Timer(const Duration(seconds: 2), () {
      if (!isLoggedIn) {
        context.pushReplacement(RouteNames.onboarding);
      } else if (!isCategoriesSeen) {
        context.pushReplacement(RouteNames.categoriesScreen);
      } else {
        context.pushReplacement(RouteNames.layoutScreen);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
            textWidget(
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
