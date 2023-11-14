import 'package:e/app/app_colors.dart';
import 'package:e/app/app_string.dart';
import 'package:flutter/material.dart';

import '../../../app/app_assets.dart';
import '../../../app/app_constant.dart';
import '../../widgets/app_buttton.dart';
import '../../widgets/textfield.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
                  const AppInputField(
                    title: AppString.email,
                    hint: AppString.emailHint,
                  ),
                  const AppSpace(axis: Axis.vertical, percentage: .03),
                  const AppInputField(
                    title: AppString.password,
                    hint: AppString.passwordHint,
                  ),
                  const AppSpace(axis: Axis.vertical, percentage: .05),
                  const AppButton(text: AppString.login),
                  const AppSpace(axis: Axis.vertical, percentage: .05),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _horizontalLine(),
                      const AppSpace(axis: Axis.horizontal, percentage: .02),
                      const Text("or"),
                      const AppSpace(axis: Axis.horizontal, percentage: .02),
                      _horizontalLine()
                    ],
                  )),
                  const AppSpace(axis: Axis.vertical, percentage: .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: AppImageBuilder(
                          path: AppAssets.githubIcon,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ).callback(onTap: () => unFocus(context)));
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
