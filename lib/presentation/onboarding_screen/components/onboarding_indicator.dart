import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

Container buildIndicator(int currentIndex, int index){
  return Container(
    height: 6,
    width: currentIndex == index ? 30 : 6,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: currentIndex == index ? AppTheme.darkColor : AppTheme.editTextGB,
    ),
  );
}