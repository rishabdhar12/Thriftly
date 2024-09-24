import 'package:budgeting_app/core/constants/assets.dart';
import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/features/analysis/presentation/views/analysis_screen.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_bloc.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_event.dart';
import 'package:budgeting_app/features/categories/presentation/bloc/local/local_categories_state.dart';
import 'package:budgeting_app/features/categories_txn/presentation/views/categories_txn_screen.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_bloc.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_event.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_state.dart';
import 'package:budgeting_app/features/home/presentation/views/home.dart';
import 'package:budgeting_app/features/profile/presentation/views/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  void initState() {
    // resetCategories();
    getCategories();
    super.initState();
  }

  getCategories() {
    BlocProvider.of<LocalCategoriesBloc>(context).add(const GetCategoriesEvent());
  }

  resetCategories() {
    BlocProvider.of<LocalCategoriesBloc>(context).add(const ResetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: SizedBox(
                height: 80.0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: ColorCodes.darkGreen,
                    selectedItemColor: ColorCodes.buttonColor,
                    unselectedItemColor: ColorCodes.white,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    iconSize: 34.0,
                    currentIndex: state.index,
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          BlocProvider.of<BottomNavigationBloc>(context).add((const HomeEvent()));
                        case 1:
                          BlocProvider.of<BottomNavigationBloc>(context)
                              .add((const AnalysisEvent()));
                        // case 2:
                        //   BlocProvider.of<BottomNavigationBloc>(context)
                        //       .add((const TransactionEvent()));
                        //   break;
                        case 2:
                          BlocProvider.of<BottomNavigationBloc>(context)
                              .add((const CategoriesTxnEvent()));
                          break;
                        case 3:
                          BlocProvider.of<BottomNavigationBloc>(context)
                              .add((const ProfileEvent()));
                          break;
                        default:
                          const Placeholder();
                      }
                    },
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home),
                        label: 'Home',
                        activeIcon: Icon(CupertinoIcons.home),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(AssetStrings.analysisIcon),
                        label: 'Analysis',
                        activeIcon: SvgPicture.asset(
                          AssetStrings.analysisIcon,
                          color: ColorCodes.buttonColor,
                        ),
                      ),
                      // BottomNavigationBarItem(
                      //   icon: SvgPicture.asset(AssetStrings.transactionIcon),
                      //   label: 'Expenses',
                      //   activeIcon: SvgPicture.asset(
                      //     AssetStrings.transactionIcon,
                      //     color: ColorCodes.buttonColor,
                      //   ),
                      // ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(AssetStrings.categoriesIcon),
                        label: 'Categories',
                        activeIcon: SvgPicture.asset(
                          AssetStrings.categoriesIcon,
                          color: ColorCodes.buttonColor,
                        ),
                      ),
                      const BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.person),
                          label: 'Profile',
                          activeIcon: Icon(CupertinoIcons.person)),
                    ],
                  ),
                ),
              ),
            ),
            body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (context, state) {
                if (state is HomeState) {
                  return BlocBuilder<LocalCategoriesBloc, LocalCategoriesState>(
                    builder: (context, categoriesState) {
                      if (categoriesState is LocalCategoriesFetchedState) {
                        // log("${categoriesState.categories}");
                        return HomeScreen(
                          categories: categoriesState.categories ?? [],
                        );
                      } else if (categoriesState is LocalCategoriesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                } else if (state is AnalysisState) {
                  return const AnalysisScreen();
                }
                // else if (state is TransactionState) {
                //   return const TransactionScreen();
                // }
                else if (state is CategoriesTxnState) {
                  return const CategoriesTxnScreen();
                } else if (state is ProfileState) {
                  return const ProfileScreen();
                } else {
                  return const SizedBox();
                }
              },
            ));
      },
    );
  }
}
