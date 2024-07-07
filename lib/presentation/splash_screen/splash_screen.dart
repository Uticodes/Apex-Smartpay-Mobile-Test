import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_images.dart';
import '../onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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

  Future<Object> appLaunch() async {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
  }

  @override
  Widget build(BuildContext context) {
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
