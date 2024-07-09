import 'package:apex_smartpay_mobile_test/presentation/home_screen/home_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text.dart';
import '../../utils/custom_app_button.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({super.key, required this.firstName});

  final String firstName;

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
        }
      });
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        child: child,
                      );
                    },
                    child: Image.asset("assets/png/ic_thumbs_up.png",
                      width: 140, height: 134,),
                  ),
                  heightMargin(32),
                  TextViewBold(
                      text: "Congratulations, ${widget.firstName}"),
                  heightMargin(12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0),
                    child: TextView(
                        text: "You’ve completed the onboarding, you can start using",
                        align: TextAlign.center,
                        fontWeight: FontWeight.w500),
                  ),
                  heightMargin(32),
                  AppButton(
                      onPressed: () {
                        context.push(const HomeScreen());
                      },
                      title: "Get Started",
                      isEnabled: true
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
