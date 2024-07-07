import 'package:apex_smartpay_mobile_test/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app_theme/app_theme.dart';
import 'data/services/dio_wrapper/dio_client_wrapper.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt<DioClientWrapper>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
