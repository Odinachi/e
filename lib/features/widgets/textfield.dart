import 'package:e/app/app_colors.dart';
import 'package:e/app/app_constant.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField(
      {super.key,
      this.title,
      this.hint,
      this.validate,
      this.controller,
      this.obscureText = false});
  final String? Function(String?)? validate;
  final String? hint;
  final String? title;
  final TextEditingController? controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && (title?.isNotEmpty ?? false))
          Text(
            title!,
            style: appStyle,
          ),
        if (title != null && (title?.isNotEmpty ?? false))
          const AppSpace(
            percentage: .01,
          ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          cursorColor: AppColors.primaryColor,
          validator: validate,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintText: hint,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: AppColors.red)),
              hintStyle: appStyle.copyWith(color: AppColors.hintGrey)),
        ),
      ],
    );
  }
}
