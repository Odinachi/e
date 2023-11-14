import 'package:e/app/app_colors.dart';
import 'package:e/app/app_route_strings.dart';
import 'package:flutter/material.dart';

import 'app/app_route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
      ),
      initialRoute: AppRouteString.initial,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}
