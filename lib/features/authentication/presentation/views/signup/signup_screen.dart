import 'dart:developer';

import 'package:budgeting_app/core/common/back_button.dart';
import 'package:budgeting_app/core/common/date_picker.dart';
import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/config/shared_prefs/keys.dart';
import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/country_codes.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/utils/snackbar.dart';
import 'package:budgeting_app/features/authentication/dto/signup_dto.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_event.dart';
import 'package:budgeting_app/features/authentication/presentation/blocs/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _fullNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _dobController = TextEditingController();

String _selectedCode = "+91";

DateTime _selectedDate = DateTime.now();

class _SignUpScreenState extends State<SignUpScreen> {
  checkUserExist() {
    context
        .read<AuthBloc>()
        .add(CheckUserExistEvent(phoneNumber: "$_selectedCode${_phoneNumberController.text}"));
  }

  void signUpUser(SignUpParams params) {
    BlocProvider.of<AuthBloc>(context).add(SignUpEvent(signUpParams: params));
  }

  void _showDatePicker() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CustomCupertinoDatePicker(
          initialDate: _selectedDate,
          onDateChanged: (DateTime newDate) {
            setState(() {
              _selectedDate = newDate;
              _dobController.text = formatter.format(_selectedDate).toString().split(" ").first;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
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
          // log(state.user.fullName);
          showSnackBar(context, message: AppStrings.otpSent);
          PreferenceHelper.saveDataInSharedPreference(
              key: PrefsKeys.verificationId, value: state.verificationId);
          showSnackBar(context, message: AppStrings.otpSent);

          context.replace(RouteNames.otpScreen);
          // context.go(RouteNames.otpScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  backButton(
                    context,
                    onPressed: () {
                      context.go(RouteNames.loginOrSignUp);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  textWidget(
                    text: AppStrings.welcome,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                            items: countryData
                                .map<DropdownMenuItem<String>>((Map<String, String> country) {
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
                          controller: _phoneNumberController,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Full Name
                  textWidget(
                    text: AppStrings.fullName,
                    fontSize: 18,
                    color: ColorCodes.lightGreen,
                  ),
                  textFormField(
                    hintText: AppStrings.yourFullName,
                    controller: _fullNameController,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 30),
                  // Email
                  textWidget(
                    text: AppStrings.email,
                    fontSize: 18,
                    color: ColorCodes.lightGreen,
                  ),
                  textFormField(
                    hintText: AppStrings.yourEmail,
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  // Email
                  textWidget(
                    text: AppStrings.dob,
                    fontSize: 18,
                    color: ColorCodes.lightGreen,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ColorCodes.lightGreen,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                          text: _dobController.text == "" ? "DD/MM/YYYY" : _dobController.text,
                          fontSize: 16,
                          color: ColorCodes.appBackground,
                        ),
                        CupertinoButton(
                          onPressed: _showDatePicker,
                          child: const Icon(CupertinoIcons.calendar),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is UserExistState) {
                          if (state.isUserExist) {
                            showSnackBar(context, message: AppStrings.userExists);
                          } else {
                            signUpUser(
                              SignUpParams(
                                fullName: _fullNameController.text,
                                phoneNumber: "$_selectedCode${_phoneNumberController.text}",
                                email: _emailController.text,
                                dob: _dobController.text,
                              ),
                            );
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
                              if (_phoneNumberController.text.isEmpty) {
                                showSnackBar(context, message: AppStrings.invalidPhNumber);
                              } else if (_fullNameController.text.isEmpty) {
                                showSnackBar(context, message: AppStrings.invalidName);
                              } else if (_emailController.text.isEmpty) {
                                showSnackBar(context, message: AppStrings.invalidEmail);
                              } else if (_dobController.text.isEmpty) {
                                showSnackBar(context, message: AppStrings.invalidDOB);
                              } else {
                                checkUserExist();
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
