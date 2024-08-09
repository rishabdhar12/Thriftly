import 'dart:developer';

import 'package:budgeting_app/core/common/date_picker.dart';
import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/country_codes.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _fullNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();
String? _selectedCode;

DateTime _selectedDate = DateTime.now();

class _SignUpScreenState extends State<SignUpScreen> {
  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CustomCupertinoDatePicker(
          initialDate: _selectedDate,
          onDateChanged: (DateTime newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  context.go(RouteNames.loginOrSignUp);
                },
                child: Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: const BoxDecoration(
                    color: ColorCodes.buttonColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.back,
                      color: ColorCodes.appBackground,
                      size: 39.0,
                    ),
                  ),
                ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedCode,
                        hint: textWidget(
                          text: _selectedCode ?? '+91',
                          fontSize: 20.0,
                          color: ColorCodes.appBackground,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCode = newValue;
                            log(_selectedCode!);
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
                controller: _phoneNumberController,
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
              textFormField(
                hintText: AppStrings.yourDOB,
                controller: _passwordController,
                textInputType: TextInputType.text,
                suffixIcon: CupertinoButton(
                  onPressed: _showDatePicker,
                  child: const Icon(CupertinoIcons.calendar),
                ),
              ),
              const SizedBox(height: 30),
              textWidget(
                text: AppStrings.password,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              textFormField(
                hintText: AppStrings.yourPassword,
                controller: _passwordController,
                textInputType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              // Confirm Password
              textWidget(
                text: AppStrings.confirmPassword,
                fontSize: 18,
                color: ColorCodes.lightGreen,
              ),
              textFormField(
                hintText: AppStrings.oneMoreTime,
                controller: _confirmPasswordController,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 40),
              Center(
                child: elevatedButton(
                  width: 190,
                  height: 45,
                  onPressed: () {
                    context.replace(RouteNames.otpScreen);
                  },
                  textWidget: textWidget(
                    text: AppStrings.submit,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: ColorCodes.appBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
