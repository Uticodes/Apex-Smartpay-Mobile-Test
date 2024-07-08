import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/presentation/signin_screen/signin_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

import '../../data/cache/shared_preference_service.dart';
import '../../di/injection.dart';
import '../../utils/app_text.dart';
import '../../utils/custom_app_button.dart';
import 'components/onboarding_indicator.dart';
import 'components/onboarding_model.dart';
import 'components/onboarding_slider.dart';
import 'components/onboarding_view.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  final _sharedPref = getIt.get<SharedPreferencesService>();
  List<SliderModel> slides = [];
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          heightMargin(68),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: getScreenWidth(24)),
                child: TextView(
                  onTap: () {
                    if (_controller?.page != 1) {
                      _controller?.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    } else {
                      _sharedPref.setHasOnboarded();
                      context.pushReplace(const SignInScreen());
                    }
                  },
                  text: 'Skip',
                  color: AppTheme.skyBlueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )),
          Expanded(
            child: PageView.builder(
              onPageChanged: (data) {
                currentIndex = data;
                setState(() {});
              },
              controller: _controller,
              itemCount: onboardingItemList.length,
              itemBuilder: (context, index) {
                OnboardingModel onboarding = onboardingItemList[index];
                return OnboardingView(
                    title: onboarding.title,
                    subTitle: onboarding.subTitle,
                    imagePathOne: onboarding.imagePathOne,
                    imagePathTwo: onboarding.imagePathTwo,
                    slides: onboardingItemList,
                    currentIndex: currentIndex
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 38.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingItemList.length, (index) => buildIndicator(currentIndex,index),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: getScreenHeight(58),
                left: getScreenWidth(44),
                right: getScreenWidth(44),
              ),
              child: AppButton(
                isEnabled: true,
                onPressed: () {
                  _sharedPref.setHasOnboarded();
                  context.pushReplace(const SignInScreen());
                },
                title: 'Get Started',
              ),
            ),
          )
        ],
      ),
    );
  }
}