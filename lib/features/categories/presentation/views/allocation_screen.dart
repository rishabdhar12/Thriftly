import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/core/utils/snackbar.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllocationScreen extends StatefulWidget {
  final List<Categories> categories;
  const AllocationScreen({super.key, required this.categories});

  @override
  State<AllocationScreen> createState() => _AllocationScreenState();
}

late List<TextEditingController> _amountControllers;

late List<String> _selectedDurations;

class _AllocationScreenState extends State<AllocationScreen> {
  @override
  void initState() {
    _initializeAmountControllers();
    _initializeSelectedDurations();
    // log("allocation screen");
    // log(widget.categories
    //     .map((category) => 'Name: ${category.name}')
    //     .toList()
    //     .toString());
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _amountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeAmountControllers() {
    _amountControllers = widget.categories
        .map((category) =>
            TextEditingController(text: category.amount.toString()))
        .toList();
  }

  void _initializeSelectedDurations() {
    _selectedDurations =
        List<String>.filled(widget.categories.length, 'Monthly');
  }

  void _updateCategoryAmounts(int i) {
    double? newAmount = double.tryParse(_amountControllers[i].text);
    if (newAmount != null) {
      widget.categories[i].amount = newAmount;
    }
    // log("Updated categories: ${widget.categories.map((c) => 'Name: ${c.name}, Amount: ${c.amount}').toList()}");
  }

  void _updateCategoryDuration(int i, String? newDuration) {
    if (newDuration != null) {
      setState(() {
        _selectedDurations[i] = newDuration;
      });
    }
    // log("Updated duration for ${widget.categories[i].name} to ${_selectedDurations[i]}");
  }

  addToLocalStorage(List<Categories> categories) {
    BlocProvider.of<LocalCategoriesBloc>(context)
        .add(AddCategoriesEvent(categories: categories));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () async {
            await addToLocalStorage(widget.categories);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            CupertinoIcons.arrow_right,
            size: 40,
          ),
        ),
      ),
      body: BlocConsumer<LocalCategoriesBloc, LocalCategoriesState>(
        listener: (context, state) {
          if (state is LocalCategoriesErrorState) {
            showSnackBar(context, message: state.message);
          }
          if (state is LocalCategoriesFinishedState) {
            showSnackBar(context, message: AppStrings.allocationSuccessful);
            context.go(RouteNames.layoutScreen);
          }
        },
        builder: (context, state) {
          if (state is LocalCategoriesLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 30.0,
              ),
            );
          }

          return Padding(
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
                        textWidget(
                            text: AppStrings.selectedCurrency, fontSize: 18.0),
                        textWidget(
                            text: AppStrings.inr,
                            fontSize: 20.0,
                            color: ColorCodes.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16.0);
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
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: ColorCodes.buttonColor,
                                    child: Icon(
                                      IconData(categories[index].iconCode,
                                          fontFamily: 'MaterialIcons'),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  textWidget(
                                    text: categories[index].name,
                                    fontSize: 18.0,
                                    color: ColorCodes.yellow,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              textWidget(
                                  text: AppStrings.allocateAmountText,
                                  fontSize: 12.0),
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
                                        prefixText: "${AppStrings.rupee}. ",
                                        onChanged: (String value) {
                                          _updateCategoryAmounts(index);
                                        }),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: ColorCodes.lightGreen,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedDurations[index],
                                          style: const TextStyle(
                                              color: ColorCodes.white),
                                          items: [
                                            DropdownMenuItem(
                                              value: 'Monthly',
                                              child: textWidget(
                                                text: "Monthly",
                                                color: ColorCodes.appBackground,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Weekly',
                                              child: textWidget(
                                                text: "Weekly",
                                                color: ColorCodes.appBackground,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Daily',
                                              child: textWidget(
                                                text: "Daily",
                                                color: ColorCodes.appBackground,
                                              ),
                                            ),
                                          ],
                                          onChanged: (String? newValue) {
                                            _updateCategoryDuration(
                                                index, newValue);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categories.removeAt(index);
                                        // log("After deletion  ${widget.categories.map((c) => 'Name: ${c.name}').toList()}");
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: ColorCodes.buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: const Icon(CupertinoIcons.trash),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
