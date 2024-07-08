import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/presentation/get_email_token_screen/cubit/get_token_state.dart';
import 'package:apex_smartpay_mobile_test/presentation/signup_screen/signup_screen.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../di/injection.dart';
import '../../utils/app_text.dart';
import '../../utils/app_toolbar.dart';
import '../../utils/constants.dart';
import '../../utils/custom_app_button.dart';
import '../../utils/flush_bar_util.dart';
import '../../utils/loader.dart';
import '../../utils/otp_timer_utils.dart';
import '../../utils/softkey_focus.dart';
import '../get_email_token_screen/cubit/get_token_cubit.dart';

class VerifyEmailTokenScreen extends StatefulWidget {
  const VerifyEmailTokenScreen(
      {super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<VerifyEmailTokenScreen> createState() => _VerifyEmailTokenScreenState();
}

class _VerifyEmailTokenScreenState extends State<VerifyEmailTokenScreen> {
  final _cubit = getIt.get<GetTokenCubit>();
  final _otpController = TextEditingController();
  bool resentOtp = false;
  String? token;

  String get _otp => _otpController.text.trim();

  @override
  void initState() {
    token = widget.otp;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _otpController.text = token.toString();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<GetTokenCubit, GetTokenState>(
          bloc: _cubit,
          listener: (context, state) {
            state.maybeWhen(
              loading: () => const LoadingView(),
              success: (response) {
                _otpController.text = response.data!.token.toString();
                setState(() {});
              },
              verifyEmailToken: (response) {
                context.push(const SignUpScreen());
              },
              error: (String errorMessage) {
                FlushBarUtil.error(errorMessage);
                debugPrint("errorMessage:: $errorMessage");
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppToolbar(
                        shouldPopBack: true,
                      ),
                      heightMargin(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextViewBold(
                            text: "Verify it's you",
                            fontWeight: FontWeight.w600,
                          ),
                          heightMargin(12),
                          RichText(
                            text: TextSpan(
                              text: "We send a code to ( ",
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 16,
                                color: AppTheme.textBlack,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: widget.email,
                                  style: const TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 16,
                                    color: AppTheme.darkColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      " ). Enter it here to verify your identity",
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 16,
                                    color: AppTheme.textBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          heightMargin(32),
                          PinCodeTextField(
                            controller: _otpController,
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
                            obscureText: false,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            validator: (v) {
                              return null;
                            },
                            pinTheme: PinTheme(
                              borderWidth: 1,
                              selectedColor: AppTheme.skyBlueColor,
                              inactiveColor:
                                  AppTheme.greyColor.withOpacity(0.1),
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(12),
                              fieldHeight: 56,
                              fieldWidth: 56,
                            ),
                            cursorColor: AppTheme.darkColor,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle:
                                const TextStyle(fontSize: 20, height: 1.6),
                            enableActiveFill: false,
                            keyboardType: TextInputType.number,
                            onCompleted: (_) => setState(() {
                              _cubit.verifyEmailToken(
                                  widget.email, token.toString());
                            }),
                            onChanged: (_) => setState(() {}),
                            onSubmitted: (_) {
                              hideKeyboard(context);
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                          ),
                          heightMargin(30),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    resentOtp
                                        ? TextView(
                                            text: "Resend OTP",
                                            color: AppTheme.darkBlueColor,
                                            onTap: () {
                                              resentOtp = !resentOtp;
                                              setState(() {});
                                              _cubit
                                                  .getEmailToken(widget.email);
                                            },
                                          )
                                        : CountDownTimer(
                                            secondsRemaining: 30,
                                            whenTimeExpires: () {
                                              resentOtp = !resentOtp;
                                              setState(() {});
                                            },
                                            countDownTimerStyle:
                                                const TextStyle(
                                                    fontFamily: fontFamily,
                                                    color: AppTheme.greyColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    decoration:
                                                        TextDecoration.none,
                                                    height: 1.5),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      heightMargin(50),
                      AppButton(
                          onPressed: () {
                            _cubit.verifyEmailToken(
                                widget.email, token.toString());
                            hideKeyboard(context);
                          },
                          title: "Confirm",
                          isEnabled:
                              _otpController.text.length == 5 ? true : false),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
