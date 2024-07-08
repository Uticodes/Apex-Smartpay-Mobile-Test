import 'package:apex_smartpay_mobile_test/presentation/signin_screen/signin_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app_theme/app_theme.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/app_toolbar.dart';
import '../../utils/constants.dart';
import '../../utils/custom_app_button.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/social_auth_button.dart';
import '../../utils/validations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  String get _email => _emailTextController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightMargin(8),
                    const AppToolbar( shouldPopBack: true,),
                    heightMargin(24),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: "Create a ",
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 24,
                                color: AppTheme.darkColor,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "Smartpay\n",
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 24,
                                    color: AppTheme.darkBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "account",
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 24,
                                    color: AppTheme.darkColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          heightMargin(30),
                          CustomTextField(
                            controller: _emailTextController,
                            hintText: "Email",
                            validator: emailTextFieldValidator,
                            onChanged: (_) => setState(() {}),
                          ),
                          heightMargin(30),
                          AppButton(
                            onPressed: () {},
                            title: "Sign Up",
                            isEnabled: isValidEmail(_email),
                          ),
                          heightMargin(32,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: getScreenWidth(142),
                                child: Divider(
                                  color: AppTheme.lightGrey,
                                  thickness: getScreenHeight(0.5),
                                ),
                              ),
                              const TextView(
                                text: 'OR',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textBlack,
                              ),
                              SizedBox(
                                width: getScreenWidth(142),
                                child: Divider(
                                  color: AppTheme.lightGrey,
                                  thickness: getScreenHeight(0.7),
                                ),
                              ),
                            ],
                          ),
                          heightMargin(24),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SocialAuthButtons(
                            icon: AppImages.googleLogo,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: SocialAuthButtons(
                            icon: AppImages.appleLogo,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    heightMargin(100),
                    Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: SizedBox(
                        width: context.width,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              color: AppTheme.textBlack,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: const TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  color: AppTheme.darkBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push(const SignInScreen());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
