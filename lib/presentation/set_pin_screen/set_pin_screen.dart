import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/presentation/congratulations_screen/congratulations_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/app_text.dart';
import '../../utils/app_toolbar.dart';
import '../../utils/constants.dart';
import '../../utils/custom_app_button.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key, required this.firstName});

  final String firstName;

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppToolbar(
                    shouldPopBack: true,
                  ),
                  heightMargin(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextViewBold(
                        text: "Set your PIN code",
                      ),
                      heightMargin(12),
                      const TextView(
                          text:
                              "We use state-of-the-art security measures to protect your information at all times",
                          fontWeight: FontWeight.w500),
                      heightMargin(32),
                      PinCodeTextField(
                        controller: _pinController,
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                            fontFamily: fontFamily,
                            color: AppTheme.darkColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            height: 1.3),
                        length: 5,
                        obscureText: true,
                        obscuringCharacter: '●',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          return null;
                        },
                        pinTheme: PinTheme(
                          borderWidth: 1,
                          selectedColor: AppTheme.darkBlueColor,
                          inactiveColor: AppTheme.darkBlueColor,
                          fieldHeight: 56,
                          fieldWidth: 56,
                        ),
                        cursorColor: AppTheme.darkBlueColor,
                        animationDuration: const Duration(milliseconds: 300),
                        textStyle: const TextStyle(fontSize: 16, height: 1.6, color: AppTheme.darkColor),
                        enableActiveFill: false,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {},
                        onChanged: (_) => setState(() {}),
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                      heightMargin(30)
                    ],
                  ),
                  heightMargin(50),
                  AppButton(
                      onPressed: () {
                        context.push(CongratulationsScreen(firstName: widget.firstName));
                      },
                      title: "Create Pin",
                      isEnabled: _pinController.text.length == 5)
                ],
              ),
            ),
          ),
        ));
  }
}
