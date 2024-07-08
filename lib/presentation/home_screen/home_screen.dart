import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightMargin(32),
                const TextViewBold(
                    text: "Your secret message is in the box \n👇👇",
                    color: AppTheme.darkBlueColor,
                    align: TextAlign.center,
                    fontSize: 16
                ),
                heightMargin(8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.darkColor,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: TextViewBold(
                        text: "Your Secret",
                        color: AppTheme.darkBlueColor,
                        fontSize: 16
                    ),
                  ),
                ),
                heightMargin(12),
              ],
            ),
          ),
        ),
      )
    );
  }
}
