import 'package:e/features/auth/view/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/orders/view/order_screen.dart';
import 'app_colors.dart';
import 'app_route_strings.dart';

class RouteGenerator {
  ///Generates routes, extracts and passes navigation arguments.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteString.initial:
        return _getPageRoute(const AuthScreen());
      case AppRouteString.order:
        return _getPageRoute(const OrderScreen());

      default:
        return _getPageRoute(_errorPage());
    }
  }

  //Wraps widget with a CupertinoPageRoute and adds route settings
  static CupertinoPageRoute _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      CupertinoPageRoute(
        builder: (context) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
      );

  ///Error page shown when app attempts navigating to an unknown route
  static Widget _errorPage({String message = "Error! Page not found"}) =>
      Scaffold(
        appBar: AppBar(
            title: const Text(
          'Page not found',
          style: TextStyle(color: AppColors.red),
        )),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(color: AppColors.red),
          ),
        ),
      );
}
