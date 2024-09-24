import 'dart:developer';

import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/header.dart';
import 'package:budgeting_app/core/common/show_balance.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/icon_data.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/utils/snackbar.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
import 'package:budgeting_app/features/categories_txn/presentation/views/widget/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesTxnScreen extends StatefulWidget {
  const CategoriesTxnScreen({super.key});

  @override
  State<CategoriesTxnScreen> createState() => _CategoriesTxnScreenState();
}

final TextEditingController _newCategoryController = TextEditingController();
final TextEditingController _amountController = TextEditingController();
String _selectedDuration = AppStrings.monthly;

class _CategoriesTxnScreenState extends State<CategoriesTxnScreen> {
  @override
  void initState() {
    BlocProvider.of<LocalCategoriesBloc>(context).add(const GetCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Header(headingText: AppStrings.categories),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
              child: Column(
                children: [
                  const ShowBalance(),
                  const SizedBox(height: 30.0),
                  BlocBuilder<LocalCategoriesBloc, LocalCategoriesState>(builder: (context, state) {
                    if (state is LocalCategoriesLoadingState) {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 30,
                          color: ColorCodes.white,
                        ),
                      );
                    }

                    if (state is LocalCategoriesFetchedState) {
                      final categories = state.categories ?? [];
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length + 1,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 40.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index < categories.length) {
                            return categoryItem(context, categories, index);
                          } else {
                            return GestureDetector(
                              onTap: () {
                                addCategoryDialog(
                                  context,
                                  controller: _newCategoryController,
                                  amountController: _amountController,
                                  selectedDuration: _selectedDuration,
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: ColorCodes.lightBlue,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 60,
                                      color: ColorCodes.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  textWidget(
                                    text: AppStrings.add,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.0,
                                    color: ColorCodes.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      );
                    }

                    return SizedBox(
                      child: Center(
                        child: textWidget(
                          text: AppStrings.nothingToShow,
                          color: ColorCodes.white,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addCategoryDialog(
    BuildContext context, {
    TextEditingController? controller,
    TextEditingController? amountController,
    required String selectedDuration,
  }) async {
    IconData selectedIcon = Icons.category;

    void addCategory(Categories category) {
      BlocProvider.of<LocalCategoriesBloc>(context).add(AddCategoryEvent(category: category));
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorCodes.appBackground,
          content: SizedBox(
            // padding: const EdgeInsets.symmetric(vertical: 20.0),
            width: MediaQuery.of(context).size.width,
            height: 480.0,
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.symmetric(horizontal: 100.0),
                  decoration: BoxDecoration(
                    color: ColorCodes.lightBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(selectedIcon, size: 30.0, color: ColorCodes.white),
                ),
                const SizedBox(height: 20.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: appIconsMap.entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          selectedIcon = entry.value;
                          (context as Element).markNeedsBuild();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                selectedIcon == entry.value ? Colors.blueAccent : Colors.grey[200],
                          ),
                          child: Icon(
                            entry.value,
                            color: selectedIcon == entry.value ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20.0),
                textFormField(
                  controller: controller,
                  hintText: AppStrings.categoryName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 20.0),
                textFormField(
                  controller: amountController,
                  hintText: AppStrings.enterAmount,
                  textInputType: TextInputType.number,
                  prefixText: "${AppStrings.rupee}. ",
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  height: 54.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: ColorCodes.lightGreen,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedDuration,
                      // value: selectedDuration,
                      style: const TextStyle(
                        color: ColorCodes.appBackground,
                        fontSize: 20.0,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: AppStrings.monthly,
                          child: textWidget(
                            text: AppStrings.monthly,
                            color: ColorCodes.appBackground,
                          ),
                        ),
                        DropdownMenuItem(
                          value: AppStrings.weekly,
                          child: textWidget(
                            text: AppStrings.weekly,
                            color: ColorCodes.appBackground,
                          ),
                        ),
                        DropdownMenuItem(
                          value: AppStrings.daily,
                          child: textWidget(
                            text: AppStrings.daily,
                            color: ColorCodes.appBackground,
                          ),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        selectedDuration = newValue!;
                        log(selectedDuration);
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                elevatedButton(
                  height: 40,
                  width: 240.0,
                  textWidget: textWidget(
                    text: AppStrings.save,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (controller!.text.isNotEmpty && amountController!.text.isNotEmpty) {
                      final category = Categories()
                        ..name = controller.text.trim()
                        ..amount = double.parse(amountController.text.trim())
                        ..amountLeft = double.parse(amountController.text.trim())
                        ..iconCode = selectedIcon.codePoint
                        ..duration = selectedDuration;
                      addCategory(category);
                      context.pop();
                      _newCategoryController.clear();
                      _amountController.clear();
                    } else {
                      context.pop();
                      showSnackBar(
                        context,
                        message: AppStrings.allFieldsMandatory,
                      );
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                elevatedButton(
                  height: 40,
                  width: 240.0,
                  buttonColor: ColorCodes.offWhite,
                  textWidget: textWidget(
                    text: AppStrings.cancel,
                    fontSize: 22.0,
                    color: ColorCodes.appBackground,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
