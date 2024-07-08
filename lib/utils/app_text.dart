import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final GlobalKey? textKey;
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? align;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final int? maxLines;
  final TextStyle? style;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;

  const TextView({
    super.key,
    this.textKey,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.align = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize = 16,
    this.lineHeight,
    this.style,
    this.maxLines,
    this.fontWeight = FontWeight.w400,
    this.decoration,
    this.fontStyle = FontStyle.normal,
    this.decorationStyle,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        key: textKey,
        style: style?.copyWith(inherit: true) ??
            context.textTheme.bodyLarge?.copyWith(
              inherit: true,
              color: color ?? AppTheme.greyColor,
              decoration: decoration,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              height: lineHeight,
              decorationStyle: decorationStyle,
              decorationColor: decorationColor,
            ),
        textAlign: align,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}

class TextViewBold extends StatelessWidget {
  final GlobalKey? textKey;
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? align;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final int? maxLines;
  final TextStyle? style;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;

  const TextViewBold({
    super.key,
    this.textKey,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.align = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize = 24,
    this.lineHeight,
    this.style,
    this.maxLines,
    this.fontWeight = FontWeight.w700,
    this.decoration,
    this.fontStyle = FontStyle.normal,
    this.decorationStyle,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        key: textKey,
        style: style?.copyWith(inherit: true) ??
            context.textTheme.bodyLarge?.copyWith(
              inherit: true,
              color: color ?? AppTheme.darkColor,
              decoration: decoration,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              height: lineHeight,
              decorationStyle: decorationStyle,
              decorationColor: decorationColor,
            ),
        textAlign: align,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}