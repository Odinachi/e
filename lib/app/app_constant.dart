import 'package:e/app/app_colors.dart';
import 'package:flutter/material.dart';

final TextStyle appStyle = TextStyle(
  color: AppColors.primaryColor,
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

class AppSpace extends StatelessWidget {
  const AppSpace({super.key, this.axis = Axis.vertical, this.percentage = .1});
  final Axis axis;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: (axis == Axis.vertical) ? size.height * percentage : null,
      width: (axis == Axis.horizontal) ? size.width * percentage : null,
    );
  }
}

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension Click on Widget {
  Widget callback({VoidCallback? onTap}) => InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: this,
      );
}
