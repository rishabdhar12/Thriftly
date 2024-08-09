import 'dart:developer';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController _phoneNumber = TextEditingController();
String? _selectedCode;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
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
                    controller: _phoneNumber,
                    textInputType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
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
    );
  }
}
