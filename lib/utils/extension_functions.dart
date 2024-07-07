import 'package:flutter/material.dart';

extension BuildContextWrapper on BuildContext {
  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  TextTheme get textTheme => Theme.of(this).textTheme;

  ButtonThemeData get buttonTheme => Theme.of(this).buttonTheme;

  void pop() {
    Navigator.of(this).pop();
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void push(Widget destination) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => destination));
  }

  void pushReplace(Widget destination) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => destination));
  }

}

double screenAwareSize(int size, BuildContext context) {
  const baseHeight = 640;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getScreenHeight(double inputHeight) {
  final screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight!;
  //896 is the height used in the UI
}

// Get the proportionate height as per screen size
double getScreenWidth(double inputWidth) {
  final screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth!;
  //414 is the width used in the UI
}

Widget heightMargin(double size) {
  return SizedBox(
    height: getScreenHeight(size),
  );
}

Widget widthMargin(double size) {
  return SizedBox(
    width: getScreenWidth(size),
  );
}
