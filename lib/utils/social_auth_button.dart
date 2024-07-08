import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthButtons extends StatelessWidget {
  final Function()? onPressed;
  final String icon;

  const SocialAuthButtons(
      {super.key,
        required this.onPressed,
        required this.icon,});

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(
              vertical: 2.5,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.btnBorderColor,
            ),
          ),
          child: Center(
              child: SvgPicture.asset(
                icon,
              )
          ),
        ));
  }
}