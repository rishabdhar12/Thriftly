import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(
          children: [
            profileItems(
              title: "Edit Profile",
              icon: CupertinoIcons.person,
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: "Settings",
              icon: CupertinoIcons.settings,
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: "Help",
              icon: CupertinoIcons.question_circle,
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: "Logout",
              icon: CupertinoIcons.power,
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: "Version",
              icon: CupertinoIcons.power,
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: "About",
              icon: CupertinoIcons.info_circle,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileItems({String title = "", IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      decoration: BoxDecoration(
        color: ColorCodes.transparentCard,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget(text: title, fontWeight: FontWeight.w600, fontSize: 16.0),
          Icon(
            // CupertinoIcons.person,
            icon,
            color: ColorCodes.white,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}
