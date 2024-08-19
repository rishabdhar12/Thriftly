import 'package:budgeting_app/features/analysis/presentation/views/analysis_screen.dart';
import 'package:budgeting_app/features/categories_txn/presentation/views/categories_txn_screen.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_bloc.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_event.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_state.dart';
import 'package:budgeting_app/features/home/presentation/views/home.dart';
import 'package:budgeting_app/features/profile/presentation/views/profile.dart';
import 'package:budgeting_app/features/transactions/presentation/views/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              currentIndex: state.index,
              onTap: (index) {
                switch (index) {
                  case 0:
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add((const HomeEvent()));
                  case 1:
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add((const AnalysisEvent()));
                  case 2:
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add((const TransactionEvent()));
                    break;
                  case 3:
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add((const CategoriesTxnEvent()));
                    break;
                  case 4:
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add((const ProfileEvent()));
                    break;
                  default:
                    const Placeholder();
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: 'Analysis',
                    activeIcon: Icon(Icons.shopping_cart)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: 'Expenses',
                    activeIcon: Icon(Icons.shopping_bag)),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: 'Categories',
                  activeIcon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                    activeIcon: Icon(Icons.person)),
              ],
            ),
            body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (context, state) {
                if (state is HomeState) {
                  return const HomeScreen();
                } else if (state is AnalysisState) {
                  return const AnalysisScreen();
                } else if (state is TransactionState) {
                  return const TransactionScreen();
                } else if (state is CategoriesTxnState) {
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
