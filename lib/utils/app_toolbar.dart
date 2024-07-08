import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_images.dart';

class AppToolbar extends StatelessWidget {
  final bool? shouldPopBack;
  const AppToolbar({
    super.key, this.shouldPopBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.lightGrey)),
        child: GestureDetector(
            onTap: () {
              shouldPopBack == true ? context.pop() : null;
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                AppImages.appBackBtn,
                height: 24,
                width: 24,
              ),
            )),
    );
  }
}
