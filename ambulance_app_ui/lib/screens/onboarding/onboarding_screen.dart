import 'package:ambulance_app_ui/core/colors.dart';
import 'package:ambulance_app_ui/core/data_constants.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int selectedPage = 0;
  late PageController pageController;

  @override
  void initState() {   
    selectedPage = 0;
    pageController = PageController(initialPage: selectedPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _createPageView(pageController, context),
            flex: 4,
          ),
          Expanded(
            flex: 2,
            child: _createStatic(context),
          )
        ],
      )),
    );
  }

  Widget _createPageView(PageController pageController, BuildContext context) {
    return PageView(
      controller: pageController,
      children: DataConstants.onboardingTiles,
      scrollDirection: Axis.horizontal,
      onPageChanged: (page) {
        setState(() {
          selectedPage = page;
        });
      },
    );
  }

  Widget _createStatic(BuildContext context) {
    final pageCount = 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PageViewDotIndicator(
        currentItem: selectedPage,
        count: pageCount,
        selectedColor: AppColors.onboardingColor,
        unselectedColor: Color.fromARGB(151, 11, 7, 17),
        duration: Duration(milliseconds: 200),
        boxShape: BoxShape.circle,
      ),
    );
  }
}
