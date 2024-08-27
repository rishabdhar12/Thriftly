import 'dart:developer';

import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/config/shared_prefs/keys.dart';
import 'package:budgeting_app/core/config/shared_prefs/shared_prefs.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/icon_data.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/remote/remote_categories_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> selectedList = [];
  List<Categories> selectedCategories = [];

  @override
  void initState() {
    BlocProvider.of<RemoteCategoriesBloc>(context).add(const GetCategories());
    super.initState();
  }

  // void add(Categories categories) {
  //   BlocProvider.of<LocalCategoriesBloc>(context)
  //       .add(AddCategoriesEvent(categories: categories));
  // }

  // void delete(String name) {
  //   BlocProvider.of<LocalCategoriesBloc>(context)
  //       .add(DeleteCategoriesEvent(name: name));
  // }

  void addToCategoriesList(String item) {
    IconData? iconCode;

    switch (item) {
      case "Rent/Mortgage":
        iconCode = appIconsMap['home'];
        break;
      case "Electricity":
        iconCode = appIconsMap['eco'];
        break;
      case "Water":
        iconCode = appIconsMap['landscape'];
        break;
      case "Internet":
        iconCode = appIconsMap['public'];
        break;
      case "Food":
        iconCode = appIconsMap['fastfood'];
        break;
      case "Household Supplies":
        iconCode = appIconsMap['shopping_cart'];
        break;
      case "Fuel":
        iconCode = appIconsMap['rocket_launch'];
        break;
      case "Public Transit":
        iconCode = appIconsMap['domain'];
        break;
      case "Maintenance":
        iconCode = appIconsMap['build'];
        break;
      case "Medical Bills":
        iconCode = appIconsMap['health_and_safety'];
        break;
      case "Health":
        iconCode = appIconsMap['monitor_heart'];
        break;
      case "Auto":
        iconCode = appIconsMap['credit_card'];
        break;
      case "Life":
        iconCode = appIconsMap['medication'];
        break;
      case "Tuition":
        iconCode = appIconsMap['school'];
        break;
      case "Books":
        iconCode = appIconsMap['emoji_objects'];
        break;
      case "Movies":
        iconCode = appIconsMap['stars'];
        break;
      case "Hobbies":
        iconCode = appIconsMap['thumb_up'];
        break;
      case "Streaming":
        iconCode = appIconsMap['tv'];
        break;
      case "Restaurants":
        iconCode = appIconsMap['restaurant'];
        break;
      case "Coffee":
        iconCode = appIconsMap['coffee'];
        break;
      case "Haircuts":
        iconCode = appIconsMap['face'];
        break;
      case "Gym":
        iconCode = appIconsMap['fitness_center'];
        break;
      case "Apparel":
        iconCode = appIconsMap['card_membership'];
        break;
      case "Accessories":
        iconCode = appIconsMap['loyalty'];
        break;
      case "Flights":
        iconCode = appIconsMap['rocket_launch'];
        break;
      case "Accommodation":
        iconCode = appIconsMap['home'];
        break;
      case "Presents":
        iconCode = appIconsMap['celebration'];
        break;
      case "Charitable Gifts":
        iconCode = appIconsMap['emoji_flags'];
        break;
      case "Subscriptions":
        iconCode = appIconsMap['verified'];
        break;
      case "Pet Care":
        iconCode = appIconsMap['pets'];
        break;
      case "Savings":
        iconCode = appIconsMap['bar_chart'];
        break;
      case "Retirement":
        iconCode = appIconsMap['leaderboard'];
        break;
      case "Investments":
        iconCode = appIconsMap['developer_mode'];
        break;
      default:
        iconCode = appIconsMap['category'];
    }

    final category = Categories()
      ..name = item
      ..iconCode = iconCode!.codePoint;

    setState(() {
      selectedList.add(item);
      selectedCategories.add(category);

      log(selectedCategories
          .map((category) => 'Name: ${category.name}')
          .toList()
          .toString());
    });
  }

  void deleteFromCategoriesList(String item) {
    setState(() {
      selectedList.remove(item);
      selectedCategories.removeWhere((category) => category.name == item);

      log(selectedCategories
          .map((category) => 'Name: ${category.name}')
          .toList()
          .toString());
    });
  }

  void allocationScreenRoutes() async {
    await PreferenceHelper.saveDataInSharedPreference(
        key: PrefsKeys.isCategoriesSeen, value: true);
    if (mounted) {
      if (selectedCategories.isEmpty) {
        context.go(RouteNames.layoutScreen);
      } else {
        context.go(RouteNames.allocationScreen, extra: selectedCategories);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            allocationScreenRoutes();
            // context.go(RouteNames.allocationScreen, extra: selectedCategories);
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget(
                text: AppStrings.categoriesText1,
                color: Colors.white,
                fontSize: 26,
              ),
              const SizedBox(height: 8),
              textWidget(
                text: AppStrings.categoriesText2,
                color: Colors.grey,
                fontSize: 18,
              ),
              BlocBuilder<RemoteCategoriesBloc, RemoteCategoriesState>(
                builder: (context, state) {
                  if (state is RemoteCategoriesLoadingState) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                        color: ColorCodes.buttonColor,
                      ),
                    );
                  } else if (state is RemoteCategoriesFinishedState) {
                    final categories = state.categoriesEntity!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                                text: categories[index].categoryName,
                                fontSize: 30,
                                color: ColorCodes.yellow),
                            Wrap(
                              spacing: 8,
                              children: categories[index]
                                  .items
                                  .map(
                                    (item) => Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.transparent,
                                      ),
                                      child: ChoiceChip(
                                          showCheckmark: false,
                                          onSelected: (bool value) async {
                                            if (value) {
                                              addToCategoriesList(item);
                                            } else {
                                              deleteFromCategoriesList(item);
                                            }
                                          },
                                          selected: selectedList.contains(item),
                                          selectedColor: ColorCodes.buttonColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: const BorderSide(
                                                color: ColorCodes.buttonColor),
                                          ),
                                          label: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: selectedList.contains(item)
                                                  ? ColorCodes.appBackground
                                                  : ColorCodes.offWhite,
                                            ),
                                          )),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 36),
                          ],
                        );
                      },
                    );
                  } else if (state is RemoteCategoriesErrorState) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const Center(child: Text('Unexpected state'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
