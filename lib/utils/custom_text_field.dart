import 'package:apex_smartpay_mobile_test/utils/app_images.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme/app_theme.dart';
import 'constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? labelText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? maxLength;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final bool isPasswordField;
  final TextAlign textAlign;
  final bool enabledTextFieldBorder;
  final bool? isFilled;
  final BorderRadius textFieldBorderRadius;
  final Color? filledColor;
  final Color? cursorColor;
  final double borderWidth, fontSize;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.labelText,
    this.errorText,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.isReadOnly = false,
    this.onTap,
    this.isPasswordField = false,
    this.textAlign = TextAlign.start,
    this.enabledTextFieldBorder = false,
    this.isFilled,
    this.cursorColor,
    this.textFieldBorderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.filledColor,
    this.borderWidth = 1.0,
    this.fontSize = 16.0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool get isPasswordField =>
      widget.isPasswordField &&
      widget.hintText.isNotEmpty &&
      widget.hintText.toLowerCase().contains('password');

  bool get isEmailField =>
      widget.label != null && widget.label!.toLowerCase().contains('email');

  bool get isPhoneNumberField =>
      widget.label != null && widget.label!.toLowerCase().contains('phone');
  bool _obscureText = true;

  final inputFormatters = <TextInputFormatter>[];

  @override
  void initState() {
    if (isPasswordField || isEmailField || isPhoneNumberField) {
      inputFormatters.add(FilteringTextInputFormatter.deny(RegExp(r'\s')));
    }
    if (isPhoneNumberField) {
      debugPrint("isPhoneNumberField");
      inputFormatters.addAll([
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InputDecorationTheme theme = Theme.of(context).inputDecorationTheme;
    final bool isDarkMode = context.colorScheme.brightness == Brightness.dark;
    debugPrint("theme isFilled ==> ${theme.filled}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          readOnly: widget.isReadOnly,
          onTap: widget.onTap,
          cursorColor: widget.cursorColor ?? AppTheme.darkColor,
          keyboardType: widget.keyboardType,
          obscureText: isPasswordField ? _obscureText : widget.obscureText,
          textInputAction: widget.textInputAction,
          style: context.textTheme.titleMedium?.copyWith(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
              color: AppTheme.darkColor,
              decoration: TextDecoration.none),
          inputFormatters: inputFormatters,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            counterText: "",
            filled: widget.isFilled ?? theme.filled,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                fontFamily: fontFamily,
                color: AppTheme.greyColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                height: 1.5),
            isDense: theme.isDense,
            fillColor: widget.filledColor ?? theme.fillColor,
            border: widget.enabledTextFieldBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          !isDarkMode ? AppTheme.grey100 : AppTheme.faintBlack,
                      width: widget.borderWidth,
                    ),
                    borderRadius: widget.textFieldBorderRadius,
                  )
                : theme.border,
            focusedBorder: widget.enabledTextFieldBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          !isDarkMode ? AppTheme.grey100 : AppTheme.faintBlack,
                      width: widget.borderWidth,
                    ),
                    borderRadius: widget.textFieldBorderRadius,
                  )
                : theme.focusedBorder,
            enabledBorder: widget.enabledTextFieldBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          !isDarkMode ? AppTheme.grey100 : AppTheme.faintBlack,
                      width: widget.borderWidth,
                    ),
                    borderRadius: widget.textFieldBorderRadius,
                  )
                : theme.enabledBorder,
            errorBorder: theme.errorBorder ??
                const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
            focusedErrorBorder: InputBorder.none,
            suffixIcon: isPasswordField
                ? IconButton(
                    icon: SvgPicture.asset(
                      _obscureText
                          ? AppImages.icVisibilityOn
                          : AppImages.icVisibilityOff,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: widget.suffixIcon,
                  ),
            contentPadding: EdgeInsets.only(
              top: widget.maxLines > 1 ? 40.0 : 12.0,
              left: 10,
              bottom: widget.prefixIcon != null || widget.suffixIcon != null
                  ? 5.0
                  : 0.0,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: widget.prefixIcon,
                  )
                : null,
          ),
        )
      ],
    );
  }
}