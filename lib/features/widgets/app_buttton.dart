import 'package:flutter/cupertino.dart';

import '../../app/app_colors.dart';
import '../../app/app_constant.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.text = "", this.onTap});
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: appStyle.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ).callback(onTap: onTap);
  }
}
