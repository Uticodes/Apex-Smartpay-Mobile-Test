import 'package:apex_smartpay_mobile_test/data/repositories/auth_repository/auth_repository.dart';
import 'package:apex_smartpay_mobile_test/di/injection.dart';
import 'package:apex_smartpay_mobile_test/presentation/get_email_token_screen/cubit/get_token_cubit.dart';
import 'package:apex_smartpay_mobile_test/presentation/get_email_token_screen/cubit/get_token_state.dart';
import 'package:apex_smartpay_mobile_test/presentation/signin_screen/signin_screen.dart';
import 'package:apex_smartpay_mobile_test/presentation/verify_email_token_screen/verify_email_token_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../app_theme/app_theme.dart';
import '../../utils/app_images.dart';
import '../../utils/app_text.dart';
import '../../utils/app_toolbar.dart';
import '../../utils/constants.dart';
import '../../utils/custom_app_button.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/flush_bar_util.dart';
import '../../utils/loader.dart';
import '../../utils/social_auth_button.dart';
import '../../utils/softkey_focus.dart';
import '../../utils/validations.dart';

class GetEmailTokenScreen extends StatefulWidget {
  const GetEmailTokenScreen({super.key});

  @override
  State<GetEmailTokenScreen> createState() => _GetEmailTokenScreenState();
}

class _GetEmailTokenScreenState extends State<GetEmailTokenScreen> {
  final _cubit = getIt.get<GetTokenCubit>();
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  String get _email => _emailTextController.text.trim();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTokenCubit(getIt.get<AuthRepository>()),
      child: BlocConsumer<GetTokenCubit, GetTokenState>(
        bloc: _cubit,
        listener: (context, state) {
          state.maybeWhen(
            error: (errorMessage) {
              FlushBarUtil.error(errorMessage);
              debugPrint("errorMessage:: $errorMessage");
            },
            loading: () => const LoadingView(),
            success: (response) {
              debugPrint("Success L message: ${response.message}");
              debugPrint("Success token: ${response.data?.token}");
              context.push(VerifyEmailTokenScreen(
                  email: _email, otp: "${response.data?.token}"));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightMargin(8),
                          const AppToolbar(shouldPopBack: true,),
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
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (_) => setState(() {}),
                                ),
                                heightMargin(30),
                                AppButton(
                                  onPressed: () {
                                    hideKeyboard(context);
                                    _cubit.getEmailToken(_email);
                                  },
                                  title: "Sign Up",
                                  isEnabled: isValidEmail(_email),
                                ),
                                heightMargin(32,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
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
        },
      ),
    );
  }
}
