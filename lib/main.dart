import 'package:apex_smartpay_mobile_test/presentation/splash_screen/splash_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:apex_smartpay_mobile_test/utils/softkey_focus.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_theme/app_theme.dart';
import 'data/services/dio_wrapper/dio_client_wrapper.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await getIt<DioClientWrapper>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return OverlaySupport.global(
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
