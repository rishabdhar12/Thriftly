import 'dart:developer';

import 'package:budgeting_app/core/config/shared_prefs/package_info.dart';
import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/features/profile/presentation/widgets/profile_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

String appVersion = "";

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getVersion();
    super.initState();
  }

  void getVersion() {
    appVersion = PackageInfoPlus.getVersion();
    log(appVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(
          children: [
            profileItems(
              title: AppStrings.editProfile,
              icon: CupertinoIcons.person,
              onPressed: () {},
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: AppStrings.settings,
              icon: CupertinoIcons.settings,
              onPressed: () {},
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: AppStrings.help,
              icon: CupertinoIcons.question_circle,
              onPressed: () {},
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: AppStrings.logout,
              icon: CupertinoIcons.power,
              onPressed: () async {
                await PreferenceHelper.clearData();
                if (context.mounted) context.replace(RouteNames.login);
              },
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: AppStrings.version,
              // icon: CupertinoIcons.info,
              desc: appVersion,
              onPressed: () {},
            ),
            const SizedBox(height: 20.0),
            profileItems(
              title: AppStrings.about,
              icon: Icons.hdr_auto_outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
