import 'dart:developer';

import 'package:budgeting_app/core/common/back_button.dart';
import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/config/shared_prefs/keys.dart';
import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/country_codes.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:budgeting_app/core/utils/snackbar.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_event.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();

final TextEditingController _phoneNumber = TextEditingController();
String _selectedCode = "+91";

class _LoginScreenState extends State<LoginScreen> {
  checkUserExist() {
    context.read<AuthBloc>().add(
        CheckUserExistEvent(phoneNumber: "$_selectedCode${_phoneNumber.text}"));
  }

  void sendOTP() {
    log(_selectedCode);
    context
        .read<AuthBloc>()
        .add(SendOtpEvent(phoneNumber: "$_selectedCode${_phoneNumber.text}"));
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          log(state.message);
          showSnackBar(context, message: state.message);
        }
        if (state is OtpSentState) {
          log(state.verificationId);
          PreferenceHelper.saveDataInSharedPreference(
              key: PrefsKeys.verificationId, value: state.verificationId);
          showSnackBar(context, message: AppStrings.otpSent);

          context.replace(RouteNames.otpScreen);
        }
        if (state is AuthenticatedState) {
          log('Authenticated!');
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  backButton(context, onPressed: () {
                    context.go(RouteNames.loginOrSignUp);
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  textWidget(
                    text: AppStrings.welcomeBack,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 30),
                  textWidget(
                    text: AppStrings.phoneNumber,
                    fontSize: 18,
                    color: ColorCodes.lightGreen,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 86,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: ColorCodes.lightGreen,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedCode,
                            hint: textWidget(
                              text: _selectedCode,
                              fontSize: 20.0,
                              color: ColorCodes.appBackground,
                              fontWeight: FontWeight.w500,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCode = newValue!;
                                log(_selectedCode);
                              });
                            },
                            items: countryData.map<DropdownMenuItem<String>>(
                                (Map<String, String> country) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: textWidget(
                                  text: '${country['code']}',
                                  fontSize: 16,
                                  color: ColorCodes.appBackground,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: textFormField(
                          hintText: AppStrings.yourPhoneNumber,
                          controller: _phoneNumber,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is UserExistState) {
                          if (state.isUserExist) {
                            showSnackBar(context,
                                message: AppStrings.userExists);
                          } else {
                            sendOTP();
                          }
                        } else if (state is AuthError) {
                          showSnackBar(context, message: state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(
                                radius: 30, color: ColorCodes.buttonColor),
                          );
                        } else {
                          return elevatedButton(
                            width: 190,
                            height: 45,
                            onPressed: () async {
                              if (_phoneNumber.text.isNotEmpty) {
                                checkUserExist();
                              } else {
                                showSnackBar(context,
                                    message: AppStrings.invalidPhNumber);
                              }
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
