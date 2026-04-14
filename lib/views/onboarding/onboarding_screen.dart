import 'package:e_learning_application_clone/services/storage_service.dart';
import 'package:e_learning_application_clone/core/theme/app_colors.dart';
import 'package:e_learning_application_clone/core/theme/app_theme.dart';
import 'package:e_learning_application_clone/models/onboarding_item.dart';
import 'package:e_learning_application_clone/routes/app_routes.dart';
import 'package:e_learning_application_clone/views/onboarding/widgets/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _pages = [
    OnboardingItem(
      image:
          'assets/images/onboarding/onboarding1.png', // Add these images to your assets
      title: 'Learn Anywhere',
      description:
          'Access your courses anytime, anywhere. Learn at your own pace with our flexible learning platform.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding/onboarding2.png',
      title: 'Interactive Learning',
      description:
          'Engage with interactive quizzes, live sessions, and hands-on projects to enhance your learning experience.',
    ),
    OnboardingItem(
      image: 'assets/images/onboarding/onboarding3.png',
      title: 'Track Progress',
      description:
          'Monitor your progress, earn certificates, and achieve your learning goals with detailed analytics.',
    ),
  ];

  void _completeOnboarding() async {
    await StorageService.setFirstTime(false);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          //PageView
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return OnboardingPageWidget(page: _pages[index]);
            },
          ),
          //skipButton
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          //Bottom Navigation
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //page indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const WormEffect(
                    dotColor: Colors.white54,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 8,
                  ),
                ),
                //next/getstarted button
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(microseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
