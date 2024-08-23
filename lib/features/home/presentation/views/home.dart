import 'package:budgeting_app/core/common/header.dart';
import 'package:budgeting_app/core/common/show_balance.dart';
import 'package:budgeting_app/features/home/presentation/views/widgets/revenue_card_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Header(),
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  ShowBalance(),
                  SizedBox(height: 30.0),
                  RevenueCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
