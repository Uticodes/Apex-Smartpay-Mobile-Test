import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../app_theme/app_theme.dart';
import 'app_text.dart';

class FlushBarUtil {
  FlushBarUtil._();

  static success(String message, {Duration duration = const Duration(seconds: 3)}) {
    // show a notification at top of screen.
    showSimpleNotification(
      duration: duration,
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppTheme.darkBlueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 24.0,
              color: Colors.white,
            ),
            widthMargin(12),
            Expanded(
              child: TextView(
                text: message.isEmpty ? 'An error occurred, please try again' : message,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
    );
  }

  /// show error notification
  static error(String message, {Duration duration = const Duration(seconds: 4)}) {
    // show a notification at top of screen.

    showSimpleNotification(
      duration: duration,
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline_outlined,
              size: 24.0,
              color: Colors.white,
            ),
            widthMargin(12),
            Expanded(
              child: TextView(
                text: message.isEmpty ? 'An error occurred, please try again' : message,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
    );
  }
}
