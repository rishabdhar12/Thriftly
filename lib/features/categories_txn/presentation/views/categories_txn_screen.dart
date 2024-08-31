import 'package:budgeting_app/core/common/elevated_button.dart';
import 'package:budgeting_app/core/common/header.dart';
import 'package:budgeting_app/core/common/show_balance.dart';
import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/common/text_form_field.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/strings.dart';
import 'package:budgeting_app/features/categories/domain/entities/local/categories_schema_isar.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
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

class _CategoriesTxnScreenState extends State<CategoriesTxnScreen> {
  @override
  void initState() {
    BlocProvider.of<LocalCategoriesBloc>(context)
        .add(const GetCategoriesEvent());
    super.initState();
  }

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const ShowBalance(),
                  const SizedBox(height: 30.0),
                  BlocBuilder<LocalCategoriesBloc, LocalCategoriesState>(
                      builder: (context, state) {
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 40.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          // final categories = categories;
                          if (index < categories.length) {
                            return categoryItem(categories, index);
                          } else {
                            return GestureDetector(
                              onTap: () {
                                addCategoryDialog(
                                  context,
                                  controller: _newCategoryController,
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
                                    text: 'Add',
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
                        child:
                            textWidget(text: "Nothing to show!", color: ColorCodes.white),
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

  Widget categoryItem(List<Categories> categories, int index) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: ColorCodes.lightBlue,
            ),
            child: GridTile(
              child: Icon(
                IconData(categories[index].iconCode,
                    fontFamily: 'MaterialIcons'),
                size: 60,
                color: ColorCodes.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        textWidget(
          text: categories[index].name,
          fontSize: 12.0,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          color: ColorCodes.white,
        ),
      ],
    );
  }
}

Future<void> addCategoryDialog(
  BuildContext context, {
  TextEditingController? controller,
}) async {
  void addCategory(Categories category) {
    BlocProvider.of<LocalCategoriesBloc>(context)
        .add(AddCategoryEvent(category: category));
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorCodes.appBackground,
        title: textWidget(
          text: 'New Category',
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              textFormField(
                controller: controller,
                hintText: "Category Name",
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 20.0),
              elevatedButton(
                height: 40,
                width: 240.0,
                textWidget: textWidget(
                  text: 'Save',
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  if (controller!.text.isNotEmpty) {
                    final category = Categories()
                      ..name = controller.text.trim();
                    addCategory(category);
                    context.pop();
                  }
                },
              ),
              const SizedBox(height: 20.0),
              elevatedButton(
                height: 40,
                width: 240.0,
                buttonColor: ColorCodes.offWhite,
                textWidget: textWidget(
                  text: 'Cancel',
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
