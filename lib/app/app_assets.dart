import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AppAssets {
  static const String _basePath = "assets/svgs";
  static const String githubIcon = "$_basePath/github.svg";
  static const String googleIcon = "$_basePath/google.svg";
}

class AppImageBuilder extends StatelessWidget {
  const AppImageBuilder(
      {super.key,
      this.path = "",
      this.height,
      this.width,
      this.color,
      this.fit});
  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      color: color,
      fit: fit ?? BoxFit.scaleDown,
    );
  }
}
