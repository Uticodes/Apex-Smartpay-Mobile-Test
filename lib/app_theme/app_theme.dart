import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static const seedColor = Color(0xFFFFFFFF);
  static const primaryColor = Color(0xFFFFFFFF);
  static const grey = Color(0xFF666666);
  static const white = Color(0xFFFFFFFF);
  static const skyBlueColor = Color(0xFF2FA2B9);
  static const darkBlueColor =  Color(0xff0A6375);
  static const darkColor = Color(0xFF111827);
  static const editTextGB = Color(0xffe0e1e1);
  static const greyColor = Color(0xFF6B7280);
  static const lightBackgroundAppBar = Color(0xFFF9FAFB);
  static const textBoldBlack = Color(0xFF111827);
  static const textBlack = Color(0xFF6B7280);
  static const lightGrey = Color(0xFFE5E7EB);
  static const grey50 = Color(0xFFEFEFEF);
  static const grey100 = Color(0xFFB3B3B3);
  static const grey300 = Color(0xFFDDDDDD);
  static const darkModeBackground = Color(0xFF313131);
  static const textNormalDarkMode = Color(0xFFC0C0C0);
  static const textBoldDarkMode = Color(0xFFDADADA);
  static const darkModeButtonDisabledColor = Color(0xFF333333);
  static const faintBlack = Color(0xFF4C4C4C);
  static const textTertiaryColor = Color(0xFFA6A6A6);
  static const btnBorderColor = Color(0xffE5E7EB);

  static final _buttonTextStyle = const TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontStyle: FontStyle.normal,
  ).copyWith(inherit: true);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    canvasColor: Colors.pink,
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontFamily: 'SF Pro Display',
        color: textBoldBlack,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: textBlack),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      primary: primaryColor,
      secondary: primaryColor,
      background: lightBackgroundAppBar,
      onPrimary: white,
      onBackground: textBoldBlack,
      surface: textBoldBlack,
      inverseSurface: grey50,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'SF Pro Display',
          color: textBoldBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textBlack),
      bodyLarge:
      TextStyle(fontFamily: 'SF Pro Display', color: textBlack, fontSize: 16),
      bodyMedium:
      TextStyle(fontFamily: 'SF Pro Display', color: textBlack, fontSize: 14),
      labelLarge: TextStyle(
          fontFamily: 'SF Pro Display',
          color: primaryColor,
          fontWeight: FontWeight.w500),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: darkColor,
      disabledColor: darkColor.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 56,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return darkColor.withOpacity(0.7);
            }
            return darkColor; // Use the component's default.
          },
        ),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return grey100;
            }
            return white; // Use the component's default.
          },
        ),
        textStyle: MaterialStateProperty.all(_buttonTextStyle),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: lightBackgroundAppBar,
      filled: true,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: textBoldBlack),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: skyBlueColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: lightBackgroundAppBar),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: darkColor,
      selectionColor: skyBlueColor,
      selectionHandleColor: skyBlueColor,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: white,
      textStyle: const TextStyle(color: darkColor),
    ),
    indicatorColor: darkColor,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      contentTextStyle: _buttonTextStyle.copyWith(color: darkColor),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // canvasColor: darkModeBackground,
    canvasColor: Colors.purple,
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkModeBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkModeBackground,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontFamily: 'SF Pro Display',
        color: white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: white),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkModeBackground,
      primary: primaryColor,
      secondary: primaryColor,
      background: darkModeBackground,
      onPrimary: white,
      onBackground: textNormalDarkMode,
      surface: textBoldDarkMode,
      inverseSurface: textBoldBlack,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'SF Pro Display',
          color: textBoldDarkMode,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textNormalDarkMode),
      bodyLarge: TextStyle(
          fontFamily: 'SF Pro Display', color: textNormalDarkMode, fontSize: 16),
      bodyMedium: TextStyle(
          fontFamily: 'SF Pro Display', color: textNormalDarkMode, fontSize: 14),
      labelLarge: TextStyle(
          fontFamily: 'SF Pro Display',
          color: primaryColor,
          fontWeight: FontWeight.w500),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      disabledColor: darkModeButtonDisabledColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return darkModeButtonDisabledColor;
            }
            return primaryColor; // Use the component's default.
          },
        ),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return faintBlack;
            }
            return white; // Use the component's default.
          },
        ),
        textStyle: MaterialStateProperty.all(_buttonTextStyle),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: grey100))),
        side: MaterialStateProperty.all(const BorderSide(color: faintBlack)),
        foregroundColor: MaterialStateProperty.all(textNormalDarkMode),
        textStyle: MaterialStateProperty.all(_buttonTextStyle),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: textBoldBlack,
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textBoldBlack)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: textBoldBlack),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: textBoldBlack),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: white,
      selectionColor: darkBlueColor,
      selectionHandleColor: darkBlueColor,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: darkModeBackground,
      textStyle: const TextStyle(color: white),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(white),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: white, linearTrackColor: textBoldBlack),
    indicatorColor: textBoldDarkMode,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: textBoldBlack,
      elevation: 2.0,
      unselectedItemColor: textTertiaryColor,
      unselectedIconTheme: IconThemeData(color: textTertiaryColor),
      selectedIconTheme: IconThemeData(color: white),
      selectedItemColor: white,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
          fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600, fontSize: 14.0),
      unselectedLabelStyle: TextStyle(
          fontFamily: 'SF Pro Display', fontWeight: FontWeight.w600, fontSize: 12.0),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: primaryColor,
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

}
