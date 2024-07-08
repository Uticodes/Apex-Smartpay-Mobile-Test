import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/app_text.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final VoidCallback onTap;
  final bool selected;
  final TextEditingController controller;

  const CountryList({
    super.key,
    required this.countryName,
    required this.countryFlag,
    required this.countryCode,
    required this.onTap,
    required this.selected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              color: AppTheme.editTextGB.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            ),
            child: CountryClickView(
              countryName: countryName,
              countryFlag: countryFlag,
              countryCode: countryCode,
              selected: selected,
            ),
          ),
        ),
      ],
    );
  }
}

class CountryClickView extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String countryCode;
  final bool selected;

  const CountryClickView({
    super.key,
    required this.countryName,
    required this.countryFlag,
    required this.countryCode,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppTheme.editTextGB.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              countryName.isNotEmpty
                  ? Row(
                children: [
                  TextView(text: countryFlag),
                  widthMargin(16),
                  TextViewBold(
                    text: countryName,
                    align: TextAlign.center,
                    fontSize: 16,
                  ),
                ],
              )
                  : const TextView(text: "Select Country"),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down_sharp, size: 16.0),
            ],
          ),
        ),
      ],
    );
  }
}
