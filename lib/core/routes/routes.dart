import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/features/authentication/presentation/login_or_signup.dart';
import 'package:budgeting_app/features/onboarding/onboarding.dart';
import 'package:budgeting_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteNames.onboarding,
          builder: (BuildContext context, GoRouterState state) {
            return const OnboardingScreen();
          },
        ),
        GoRoute(
          path: RouteNames.loginOrSignUp,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginOrSignUp();
          },
        ),
      ],
    ),
  ],
);
