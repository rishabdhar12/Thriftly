import 'package:budgeting_app/core/common/text.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/categories_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    BlocProvider.of<RemoteFirebaseCategoriesBloc>(context)
        .add(const GetCategories());
    super.initState();
  }

  List<String> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: BlocBuilder<RemoteFirebaseCategoriesBloc,
            RemoteFirebaseConfigState>(
          builder: (context, state) {
            if (state is RemoteFirebaseConfigLoadingState) {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                  color: ColorCodes.buttonColor,
                ),
              );
            } else if (state is RemoteFirebaseConfigFinishedState) {
              final categories = state.categoriesEntity!;
              return ListView.builder(
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
                                    onSelected: (bool value) {
                                      setState(() {
                                        if (value) {
                                          selectedList.add(item);
                                        } else {
                                          selectedList.remove(item);
                                        }
                                      });
                                    },
                                    selected: selectedList.contains(item),
                                    selectedColor: ColorCodes.buttonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
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
            } else if (state is RemoteFirebaseConfigErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
