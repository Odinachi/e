import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e/app/app_colors.dart';
import 'package:e/app/app_route_strings.dart';
import 'package:e/app/app_string.dart';
import 'package:e/features/auth/data/auth_service.dart';
import 'package:e/features/auth/view_model/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app_route_generator.dart';
import 'features/orders/view_model/orders_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(globalAuthService)),
        BlocProvider<OrderCubit>(
            create: (_) => OrderCubit(FirebaseFirestore.instance)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          scaffoldBackgroundColor: AppColors.white,
          useMaterial3: true,
        ),
        initialRoute: globalAuthService.loggedIn
            ? AppRouteString.order
            : AppRouteString.initial,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
      ),
    );
  }
}

final globalAuthService = AuthService(firebaseAuth: FirebaseAuth.instance);
