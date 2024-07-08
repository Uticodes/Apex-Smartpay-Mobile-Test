import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? child;
  final double width, height;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final Color? bgColor, textColor;

  AppButton({
    super.key,
    this.title,
    this.width = double.infinity,
    this.height = 52,
    this.onPressed,
    this.isEnabled = true,
    this.child,
    this.bgColor,
    this.textColor,
  }) {
    if (child == null) {
      assert(title != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: WidgetStatePropertyAll(bgColor),
              foregroundColor: WidgetStatePropertyAll(textColor),
            ),
        onPressed: !isEnabled ? null : onPressed,
        child: child ??
            Center(
                child: TextView(
              text: title!,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
            )),
      ),
    );
  }
}
