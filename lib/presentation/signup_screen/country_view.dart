import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/extension_functions.dart';

class CountryView extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final Function? onTap;
  final bool isSelected;
  final bool index;
  final ValueChanged<String>? onChanged;

  const CountryView({
    super.key,
    required this.countryName,
    required this.countryFlag,
    required this.countryCode,
    this.onTap,
    required this.isSelected,
    this.onChanged,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: context.width,
          decoration: BoxDecoration(
            color: index ? AppTheme.editTextGB.withOpacity(0.2) : null,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isSelected)
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextView(text: countryFlag),
                        widthMargin(8),
                        TextView(text: countryCode),
                        widthMargin(8),
                        Expanded(
                          child: TextView(
                            text: countryName,
                            fontSize: 16,
                            color: AppTheme.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const TextView(text: "Select Country"),
                widthMargin(16),
                SvgPicture.asset(
                  isSelected
                      ? (index ? AppImages.icCheck : "")
                      : AppImages.dropdownIcon,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

