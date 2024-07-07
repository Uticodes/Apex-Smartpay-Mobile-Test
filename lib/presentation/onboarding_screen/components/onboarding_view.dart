import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/app_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/extension_functions.dart';
import 'onboarding_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.slides,
    required this.currentIndex,
    required this.imagePathOne,
    required this.imagePathTwo,
  });
  final String title, subTitle, imagePathOne, imagePathTwo;
  final int currentIndex;
  final List<OnboardingModel> slides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: getScreenHeight(96),
                bottom: getScreenHeight(108),
                left: getScreenWidth(45),
                right: getScreenWidth(45),
              ),
              child: Image.asset(imagePathOne),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getScreenHeight(112),
              bottom: getScreenHeight(203),
              left: getScreenWidth(53),
              right: getScreenWidth(45),
            ),
            child: Image.asset(imagePathTwo),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(color: AppTheme.white, boxShadow: [
                BoxShadow(
                  color: AppTheme.white.withOpacity(0.5),
                  blurRadius: getScreenHeight(5),
                  blurStyle: BlurStyle.solid,
                  spreadRadius: getScreenHeight(30),
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: AppTheme.white.withOpacity(0.6),
                  blurRadius: getScreenHeight(5),
                  blurStyle: BlurStyle.solid,
                  spreadRadius: getScreenHeight(30),
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: AppTheme.white.withOpacity(0.7),
                  blurRadius: getScreenHeight(5),
                  blurStyle: BlurStyle.solid,
                  spreadRadius: getScreenHeight(20),
                  offset: const Offset(0, 0),
                ),
              ]),
              height: getScreenHeight(223),
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getScreenWidth(44)),
                child: Column(
                  children: [
                    heightMargin(46),
                    TextView(
                      text: title,
                      color: AppTheme.darkColor,
                      align: TextAlign.center,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                    ),
                    heightMargin(16),
                    TextView(
                      text: subTitle,
                      align: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.greyColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
