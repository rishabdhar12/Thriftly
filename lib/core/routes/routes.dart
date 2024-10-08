import 'package:budgeting_app/core/common/page_transition.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/features/authentication/presentation/views/login/login.dart';
import 'package:budgeting_app/features/authentication/presentation/views/login/otp_screen.dart';
import 'package:budgeting_app/features/authentication/presentation/views/login_or_signup.dart';
import 'package:budgeting_app/features/authentication/presentation/views/signup/signup_screen.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/presentation/views/allocation_screen.dart';
import 'package:budgeting_app/features/categories/presentation/views/categories_screen.dart';
import 'package:budgeting_app/features/home/presentation/views/layout.dart';
import 'package:budgeting_app/features/onboarding/onboarding.dart';
import 'package:budgeting_app/features/onboarding/onboarding_two.dart';
import 'package:budgeting_app/features/splash/splash_screen.dart';
import 'package:budgeting_app/features/transactions/presentation/views/expense_history.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: RouteNames.onboardingTwo,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingTwo();
      },
    ),
    GoRoute(
      path: RouteNames.loginOrSignUp,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: const LoginOrSignUp(),
        type: 'fade',
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: const LoginScreen(),
        type: 'slide-right-to-left',
      ),
    ),
    GoRoute(
      path: RouteNames.otpScreen,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: const OtpScreen(),
        type: 'slide-right-to-left',
      ),
    ),
    GoRoute(
      path: RouteNames.signUp,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: const SignUpScreen(),
        type: 'slide-right-to-left',
      ),
    ),
    GoRoute(
      path: RouteNames.categoriesScreen,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: const CategoriesScreen(),
        type: 'slide-right-to-left',
      ),
    ),
    GoRoute(
      path: RouteNames.layoutScreen,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: const LayoutPage(),
        type: 'slide-right-to-left',
      ),
    ),
    GoRoute(
      path: RouteNames.allocationScreen,
      pageBuilder: (context, state) =>
          RouterTransitionFactory.getTransitionPage(
        context: context,
        state: state,
        child: AllocationScreen(
          categories: state.extra as List<Categories>,
        ),
        type: 'slide-right-to-left',
      ),
    ),
    GoRoute(
        path: RouteNames.expenseHistoryScreen,
        pageBuilder: (context, state) {
          Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
          return RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: ExpenseHistoryScreen(
                id: extra['id'],
                iconCode: extra['iconCode'],
                totalBudget: extra['totalBudget']),
            type: 'slide-right-to-left',
          );
        }),
  ],
);
