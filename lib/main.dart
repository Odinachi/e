import 'package:e/app/app_colors.dart';
import 'package:e/app/app_route_strings.dart';
import 'package:e/features/auth/data/auth_service.dart';
import 'package:e/features/auth/view_model/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(globalAuthService)),
      ],
      child: MaterialApp(
        title: 'E App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          scaffoldBackgroundColor: AppColors.white,
          useMaterial3: true,
        ),
        initialRoute: AppRouteString.initial,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
      ),
    );
  }
}

final globalAuthService = AuthService(firebaseAuth: FirebaseAuth.instance);
