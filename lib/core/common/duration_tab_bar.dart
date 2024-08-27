import 'package:budgeting_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget durationTabBar(TabController? tabController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: ColorCodes.transparentCard,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TabBar(
            controller: tabController,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: const Color(0xFF20C997),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelColor: ColorCodes.appBackground,
            unselectedLabelColor: ColorCodes.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Daily'),
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
            ],
          ),
        ),
      ],
    ),
  );
}
