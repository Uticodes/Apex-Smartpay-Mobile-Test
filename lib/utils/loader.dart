import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'extension_functions.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: AppTheme.darkBlueColor,
        ),
      ),
    );
  }
}