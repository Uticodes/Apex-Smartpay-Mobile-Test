import 'package:apex_smartpay_mobile_test/app_theme/app_theme.dart';
import 'package:apex_smartpay_mobile_test/presentation/home_screen/cubit/home_cubit.dart';
import 'package:apex_smartpay_mobile_test/presentation/home_screen/cubit/home_state.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../utils/app_text.dart';
import '../../utils/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cubit = getIt.get<HomeCubit>();
  String? secret;
  bool showSecret = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
      bloc: _cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: state.maybeWhen(
              orElse: () {
                return Container();
              },
              loading: () => const LoadingView(),
              success: (response) {
                final nameParts = widget.userName.trim().split(' ');

                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightMargin(12),
                      TextViewBold(
                        text: "Hi ${nameParts.first}! 👋",
                      ),
                      heightMargin(8),
                      const TextView(
                          text:
                              "Your secret message is in the box below, click on the box to view.",
                          color: AppTheme.darkColor,
                          fontSize: 16),
                      heightMargin(108),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showSecret = !showSecret;
                          });
                        },
                        child: Container(
                          width: context.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.darkColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextViewBold(
                                text: showSecret
                                    ? response.data?.secret ?? ""
                                    : "Click to reveal the secret",
                                color: AppTheme.darkBlueColor,
                                align: TextAlign.center,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      heightMargin(12),
                    ],
                  ),
                );
              }),
        );
      },
    ));
  }
}
