import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/presentation/get_email_token_screen/signup_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/app_text.dart';
import 'package:apex_smartpay_mobile_test/utils/constants.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/app_images.dart';
import '../../utils/app_toolbar.dart';
import '../../utils/custom_app_button.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/social_auth_button.dart';
import '../../utils/validations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  String get _email => _emailTextController.text.trim();

  String get _password => _passwordTextController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(48.0),
        child: SizedBox(
          width: context.width,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Don’t have an account? ",
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                color: AppTheme.textBlack,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: "Sign Up",
                  style: const TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                    color: AppTheme.darkBlueColor,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    context.push(const GetEmailTokenScreen());
                    },
                ),
              ],
            ),
          ),
        ),
      ),
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
                    const AppToolbar(),
                    heightMargin(24),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextViewBold(text: "Hi There! 👋"),
                          heightMargin(8),
                          const TextView(
                            text: "Welcome back, Sign in to your account",
                            fontWeight: FontWeight.w500,
                          ),
                          heightMargin(30),
                          CustomTextField(
                            controller: _emailTextController,
                            hintText: "Email",
                            validator: emailTextFieldValidator,
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: _passwordTextController,
                            hintText: "Password",
                            validator: passwordTextFieldValidator,
                            textInputAction: TextInputAction.done,
                            isPasswordField: true,
                            onChanged: (_) => setState(() {}),
                          ),
                          heightMargin(24),
                          const TextView(
                            text: "Forgot Password?",
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueColor,
                          ),
                          heightMargin(24),
                          AppButton(
                            onPressed: () {},
                            title: "Sign In",
                            isEnabled: isValidEmail(_email) &&
                                isValidPassword(_password),
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
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
