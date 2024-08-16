import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:budgeting_app/core/di/dependency_injection.dart';
import 'package:budgeting_app/core/routes/routes.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferenceHelper.init();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<RemoteCategoriesBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LocalCategoriesBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorCodes.appBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: ColorCodes.buttonColor),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routerConfig: router,
        // routerDelegate: router.routerDelegate,
        // routeInformationParser: router.routeInformationParser,
      ),
    );
  }
}
