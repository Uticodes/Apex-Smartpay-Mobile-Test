import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

import '../../data/cache/shared_preference_service.dart';
import '../../di/injection.dart';
import '../../utils/app_text.dart';
import '../../utils/custom_app_button.dart';
import '../signin_screen/signin_screen.dart';
import 'components/onboarding_indicator.dart';
import 'components/onboarding_slider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
      body: SizedBox(
        height: context.height,
        child: Stack(
            children:[
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50,),
                      width: context.width,
                      child: GestureDetector(
                        onTap: (){
                          context.pushReplace(const SignInScreen());
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(top: 16.0, right: 24),
                            child: TextView(
                                text: "Skip",
                                fontSize: 16,
                                color: AppTheme.skyBlueColor,
                                align :TextAlign.right,
                              onTap: () {
                                _sharedPref.setHasOnboarded();
                                context.pushReplace(const SignInScreen());
                              },
                          ),
                        ),
                      ),
                    ),
                    heightMargin(46),
                    SizedBox(
                      height: 585,
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value){
                            setState(() {
                              currentIndex = value;
                            });
                          },
                          itemCount: slides.length,
                          itemBuilder: (context, index){
                            return OnboardingSlider(
                              image: slides[index].getImage(),
                              title: slides[index].getTitle(),
                              description: slides[index].getDescription(),
                            );
                          }
                      ),
                    ),
                    const SizedBox(height: 24,),
                    // Container created for dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(slides.length, (index) => buildIndicator(currentIndex,index),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:  Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: 34, bottom: 54, left: 24, right: 24),
                  //width: double.infinity,
                  child: AppButton(
                    title: 'Get Started',
                    isEnabled: true,
                    onPressed: () async {
                      _sharedPref.setHasOnboarded();
                      context.pushReplace(const SignInScreen());
                    },
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}
