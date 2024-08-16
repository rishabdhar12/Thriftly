import 'dart:developer';

import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/config/shared_prefs/keys.dart';
import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:budgeting_app/core/utils/snackbar.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_event.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          if (i < _controllers.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          } else {
            FocusScope.of(context).unfocus();
          }
        } else if (_controllers[i].text.isEmpty && i > 0) {
          FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void verifyOtp() async {
    String id = await PreferenceHelper.getDataFromSharedPreference(
        key: "verificationId");
    String combinedText =
        _controllers.map((controller) => controller.text).join();
    log(combinedText);
    if (mounted) {
      context
          .read<AuthBloc>()
          .add(VerifyOtpEvent(verificationId: id, otp: combinedText));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          log(state.message);
          showSnackBar(context, message: state.message);
        }

        if (state is AuthenticatedState) {
          log('Authenticated!');
          PreferenceHelper.saveDataInSharedPreference(
              key: PrefsKeys.isLoggedIn, value: true);
          showSnackBar(context, message: AppStrings.loggedIn);
          context.go(RouteNames.categoriesScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textWidget(
                  text: AppStrings.enterOTP,
                  fontSize: 24,
                  color: ColorCodes.lightGreen,
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    context.go(RouteNames.loginOrSignUp);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 45,
                        height: 64,
                        decoration: BoxDecoration(
                          color: ColorCodes.lightGreen,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 60),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CupertinoActivityIndicator(
                          radius: 30, color: ColorCodes.buttonColor);
                    } else {
                      return elevatedButton(
                        width: 190,
                        height: 45,
                        onPressed: () {
                          verifyOtp();
                        },
                        textWidget: textWidget(
                          text: AppStrings.submit,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ColorCodes.appBackground,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: textWidget(
                    text: AppStrings.resendOTP,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorCodes.lightGreen,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
