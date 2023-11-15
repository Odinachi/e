import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:e/app/app_colors.dart';
import 'package:e/features/orders/view_model/orders_cubit.dart';
import 'package:e/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../app/app_constant.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void dispose() {
    super.dispose();
    channelMessageSubscription?.cancel();
  }

  StreamSubscription<ably.Message>? channelMessageSubscription;

  List<String> orders = ['one'];
  final clientOptions = ably.ClientOptions(key: dotenv.get("ablyKey"));

  void conf() {
    channelMessageSubscription = ably.Realtime(options: clientOptions)
        .channels
        .get("Item1")
        .subscribe()
        .listen((event) {
      print("listen kkkk ${event.data}");
      print("listen kkkk ${event.name}");
      print("listen kkkk ${event.timestamp}");
      print("listen kkkk ${event.extras?.map}");
      print("=======================");
    });
  }

  void load() {
    ably.Realtime(options: clientOptions)
        .channels
        .get("Item1")
        .publish(data: {"KKKKKKKKK": "hshshhshhs"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppSpace(axis: Axis.vertical, percentage: .05),
                Text(
                  "Hi, ${globalAuthService.name ?? ""}",
                  style: appStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                  textAlign: TextAlign.start,
                ),
                const AppSpace(axis: Axis.vertical, percentage: .05),
                StreamBuilder(
                    stream: context.read<OrderCubit>().orderStream(),
                    builder: (_, snapshot) {return SizedBox();})
              ],
            ),
          ),
        ).callback(onTap: () => unFocus(context)));
  }
}
