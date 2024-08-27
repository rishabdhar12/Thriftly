import 'package:budgeting_app/core/common/data_table_view.dart';
import 'package:budgeting_app/core/common/duration_tab_bar.dart';
import 'package:budgeting_app/core/common/header.dart';
import 'package:budgeting_app/core/common/show_balance.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/home/presentation/views/widgets/revenue_card_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Categories> categories;
  const HomeScreen({super.key, required this.categories});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TabController? tabController;

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Header(),
            const SizedBox(height: 40.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  ShowBalance(),
                  SizedBox(height: 30.0),
                  RevenueCard(),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
            durationTabBar(tabController),
            const SizedBox(height: 12),
            SizedBox(
              height: 300.0,
              child: TabBarView(
                controller: tabController,
                children: [
                  DataTableView(
                      duration: "Daily", categories: widget.categories),
                  DataTableView(
                      duration: "Weekly", categories: widget.categories),
                  DataTableView(
                      duration: "Monthly", categories: widget.categories),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
