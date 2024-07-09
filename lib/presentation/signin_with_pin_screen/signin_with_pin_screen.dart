import 'package:apex_smartpay_mobile_test/presentation/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../app_theme/app_theme.dart';
import '../../data/cache/shared_preference_service.dart';
import '../../di/injection.dart';
import '../../utils/app_text.dart';
import '../../utils/constants.dart';
import '../../utils/custom_app_button.dart';
import '../../utils/extension_functions.dart';
import '../../utils/flush_bar_util.dart';
import '../../utils/loader.dart';
import '../signin_screen/cubit/signin_cubit.dart';
import '../signin_screen/cubit/signin_state.dart';

class SignInWithPinScreen extends StatefulWidget {
  const SignInWithPinScreen({super.key});

  @override
  State<SignInWithPinScreen> createState() => _SignInWithPinScreenState();
}

class _SignInWithPinScreenState extends State<SignInWithPinScreen> {
  final _sharedPref = getIt.get<SharedPreferencesService>();
  final _cubit = getIt.get<SignInCubit>();
  final _pinController = TextEditingController();
  bool hideInput = false;
  String? name;
  String? userPin;
  String? userPass;
  String? userEmail;

  String get _pin => _pinController.text.trim();

  @override
  void initState() {
    name = _sharedPref.currentUserInfo?.fullName.split(' ').first;
    preloadUserDetails();
    super.initState();
  }

  preloadUserDetails() async {
    userPin = await secureStorage.read(key: AppKeys.userPin);
    userPass = await secureStorage.read(key: AppKeys.userPassword);
    userEmail = await secureStorage.read(key: AppKeys.userEmail);
    debugPrint("userPin: $userPin, userPass: $userPass, userEmail: $userEmail");
    setState(() {});
  }

  verifyPin() {
    hideInput = !hideInput;
    if (_pin == userPin) {
      _cubit.login(email: userEmail.toString(), password: userPass.toString());
    } else {
      hideInput = !hideInput;
      FlushBarUtil.error("Wrong PIN, try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SignInCubit, SignInState>(
          bloc: _cubit,
          listener: (context, state) {
            state.maybeWhen(
              error: (errorMessage, errors) {
                hideInput = !hideInput;
                handleError(errorMessage, errors: errors);
              },
              success: (response) {
                _sharedPref.setHasSignedIn();
                // name = "${response.data?.user?.fullName}";
                context.pushReplace(HomeScreen(
                  userName: name.toString(),
                ));
                setState(() {});
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return SafeArea(
                child: state.maybeWhen(
                    loading: () => const LoadingView(),
                    orElse: () {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // const AppToolbar(
                              //   shouldPopBack: true,
                              // ),
                              heightMargin(30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextViewBold(
                                    text: "Welcome back, $name!",
                                  ),
                                  heightMargin(12),
                                  const TextView(
                                      text: "Enter your login PIN",
                                      fontWeight: FontWeight.w500),
                                  heightMargin(32),
                                  hideInput
                                      ? Container()
                                      : PinCodeTextField(
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
                                            selectedColor:
                                                AppTheme.darkBlueColor,
                                            inactiveColor:
                                                AppTheme.darkBlueColor,
                                            fieldHeight: 56,
                                            fieldWidth: 56,
                                          ),
                                          cursorColor: AppTheme.darkBlueColor,
                                          animationDuration:
                                              const Duration(milliseconds: 300),
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              height: 1.6,
                                              color: AppTheme.darkColor),
                                          enableActiveFill: false,
                                          keyboardType: TextInputType.number,
                                          onCompleted: (v) {},
                                          onChanged: (_) => setState(() {}),
                                          beforeTextPaste: (text) {
                                            debugPrint(
                                                "Allowing to paste $text");
                                            return true;
                                          },
                                        ),
                                  heightMargin(16),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextView(
                                          text: "Forgot PIN?",
                                          color: AppTheme.darkBlueColor,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                  heightMargin(30)
                                ],
                              ),
                              heightMargin(50),
                              AppButton(
                                  onPressed: () {
                                    verifyPin();
                                  },
                                  title: "Create Pin",
                                  isEnabled: _pinController.text.length == 5)
                            ],
                          ),
                        ),
                      );
                    }));
          },
        ));
  }
}
