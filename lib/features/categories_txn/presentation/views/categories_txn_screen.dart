import 'package:budgeting_app/core/common/text.dart';
import 'package:flutter/material.dart';

class CategoriesTxnScreen extends StatefulWidget {
  const CategoriesTxnScreen({super.key});

  @override
  State<CategoriesTxnScreen> createState() => _CategoriesTxnScreenState();
}

class _CategoriesTxnScreenState extends State<CategoriesTxnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: textWidget(text: "Categories screen"),
      ),
    );
  }
}
