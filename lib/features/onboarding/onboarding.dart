import 'package:budgeting_app/core/constants/colors.dart';
import 'package:budgeting_app/core/constants/route_names.dart';
import 'package:budgeting_app/features/onboarding/onboarding_one.dart';
import 'package:budgeting_app/features/onboarding/onboarding_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _pageController.page;
    if (page != null) {
      setState(() {
        _currentPage = page.round();
      });
    }
  }

  _onNextPressed() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pushReplacement(RouteNames.loginOrSignUp);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPageIndicator(),
          SizedBox(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              onPressed: () {
                _onNextPressed();
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
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                OnboardingOne(),
                OnboardingTwo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) => _buildIndicator(index)),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: _currentPage == index ? 15.0 : 30.0,
      height: _currentPage == index ? 15.0 : 15.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: _currentPage == index
              ? Colors.transparent
              : ColorCodes.lightGreen,
        ),
        color:
            _currentPage == index ? ColorCodes.lightGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
