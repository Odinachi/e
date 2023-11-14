import 'package:e/app/app_colors.dart';
import 'package:e/app/app_string.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_constant.dart';
import '../../widgets/app_buttton.dart';
import '../../widgets/textfield.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool passVisible = false;
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppSpace(axis: Axis.vertical, percentage: .05),
            Text(
              'E App',
              style: appStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const AppSpace(axis: Axis.vertical, percentage: .05),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          isLogin ? AppString.login : AppString.register,
                          style: appStyle.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const AppSpace(axis: Axis.vertical, percentage: .03),
                  const AppInputField(
                    title: AppString.email,
                    hint: AppString.emailHint,
                  ),
                  const AppSpace(axis: Axis.vertical, percentage: .03),
                  AppInputField(
                    title: AppString.password,
                    hint: AppString.passwordHint,
                    obscureText: !passVisible,
                    suffixIcon: Icon(
                      passVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.primaryColor,
                    ).callback(
                        onTap: () => setState(() {
                              passVisible = !passVisible;
                            })),
                  ),
                  const AppSpace(axis: Axis.vertical, percentage: .05),
                  AppButton(
                      text: isLogin ? AppString.login : AppString.register),
                  const AppSpace(axis: Axis.vertical, percentage: .02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                " ${isLogin ? AppString.register : AppString.login}",
                            style: appStyle.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => setState(() {
                                    isLogin = !isLogin;
                                  }))
                      ],
                      text: isLogin
                          ? AppString.newMember
                          : AppString.alreadyMember,
                      style: appStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const AppSpace(axis: Axis.vertical, percentage: .05),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _horizontalLine(),
                      const AppSpace(axis: Axis.horizontal, percentage: .02),
                      const Text(AppString.or),
                      const AppSpace(axis: Axis.horizontal, percentage: .02),
                      _horizontalLine()
                    ],
                  )),
                  const AppSpace(axis: Axis.vertical, percentage: .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialContainer(
                          icon: AppAssets.googleIcon, callback: () {}),
                      const AppSpace(axis: Axis.horizontal, percentage: .1),
                      _socialContainer(
                          icon: AppAssets.githubIcon, callback: () {}),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ).callback(onTap: () => unFocus(context)));
  }

  Widget _socialContainer({required String icon, VoidCallback? callback}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.black)),
      height: 50,
      width: 50,
      child: AppImageBuilder(
        path: icon,
        fit: BoxFit.cover,
      ),
    ).callback(onTap: callback);
  }

  Center _horizontalLine() {
    return Center(
      child: Container(
        width: 100,
        color: AppColors.hintGrey,
        height: 1,
      ),
    );
  }
}
