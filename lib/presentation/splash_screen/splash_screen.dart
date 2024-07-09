import 'package:apex_smartpay_mobile_test/utils/constants.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/cache/shared_preference_service.dart';
import '../../di/injection.dart';
import '../../utils/app_images.dart';
import '../onboarding_screen/onboarding_screen.dart';
import '../signin_screen/signin_screen.dart';
import '../signin_with_pin_screen/signin_with_pin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final sharedPref = getIt.get<SharedPreferencesService>();
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              appLaunch();
            }
          });
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  // Future<void> _fetchUserPin() async {
  //   final userPin = await _sharedPref.getUserPin();
  //   setState(() {
  //     _userPin = userPin;
  //   });
  // }

  Future<bool> hasSetPin() async {
    final String? hasSetPin = await secureStorage.read(key: AppKeys.accessToken);
    return hasSetPin == 'true';
  }

  Future<void> appLaunch() async {
    final String? accessToken = await secureStorage.read(key: AppKeys.accessToken);
    final bool hasLoggedIn =
        sharedPref.hasOnboarded && sharedPref.hasPin && sharedPref.currentUserInfo != null && accessToken != null;
    debugPrint("currentUserInfo is ${sharedPref.currentUserInfo}");
    debugPrint("sharedPref.hasOnboarded ${sharedPref.hasOnboarded}");
    debugPrint("accessToken $accessToken");
    if (hasLoggedIn) {
      return context.pushReplace(const SignInWithPinScreen());
    } else if(sharedPref.hasOnboarded){
      return context.pushReplace(const SignInScreen());
    } else {
      return context.pushReplace(const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: SvgPicture.asset(AppImages.appSplashLogo),
            ),
          ],
        ),
      ),
    );
  }
}
