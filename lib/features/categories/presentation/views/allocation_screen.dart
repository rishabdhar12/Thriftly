import 'dart:developer';

import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/string.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:flutter/material.dart';

class AllocationScreen extends StatefulWidget {
  final List<Categories> categories;
  const AllocationScreen({super.key, required this.categories});

  @override
  State<AllocationScreen> createState() => _AllocationScreenState();
}

late List<TextEditingController> _amountControllers;

class _AllocationScreenState extends State<AllocationScreen> {
  @override
  void initState() {
    _initializeAmountControllers();
    log("allocation screen");
    log(widget.categories
        .map((category) => 'Name: ${category.name}')
        .toList()
        .toString());
    super.initState();
  }

  void _initializeAmountControllers() {
    _amountControllers = widget.categories
        .map((category) =>
            TextEditingController(text: category.amount.toString()))
        .toList();
  }

  void _updateCategoryAmounts() {
    for (int i = 0; i < widget.categories.length; i++) {
      double? newAmount = double.tryParse(_amountControllers[i].text);
      if (newAmount != null) {
        widget.categories[i].amount = newAmount;
      }
    }
    log("Updated categories: ${widget.categories.map((c) => 'Name: ${c.name}, Amount: ${c.amount}').toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              textWidget(
                text: AppStrings.allocateMoneyText,
                color: Colors.white,
                fontSize: 26,
              ),
              const SizedBox(height: 8),
              textWidget(
                text: AppStrings.categoriesText2,
                color: Colors.grey,
                fontSize: 18,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 14.0),
                decoration: BoxDecoration(
                  color: ColorCodes.transparentCard,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    textWidget(text: "Selected currency", fontSize: 18.0),
                    textWidget(
                        text: "INR", fontSize: 20.0, color: ColorCodes.grey),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 14.0);
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    final categories = widget.categories;
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                          color: ColorCodes.transparentCard,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textWidget(
                              text: categories[index].name,
                              fontSize: 18.0,
                              color: ColorCodes.yellow,
                            ),
                            const SizedBox(height: 12),
                            textWidget(text: "Allocate amount", fontSize: 12.0),
                            const SizedBox(height: 12),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: textFormField(
                                      controller: _amountControllers[index],
                                      textInputType: TextInputType.number,
                                      borderRadius: 10.0,
                                      height: 46.0,
                                      contentPaddingVertical: 11.5,
                                      prefixText: "₹. ",
                                      onChanged: (String value) {
                                        _updateCategoryAmounts();
                                      }),
                                ),
                                const SizedBox(width: 10.0),
                              ],
                            )
                          ],
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
