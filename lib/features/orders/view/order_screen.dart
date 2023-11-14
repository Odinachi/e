import 'package:flutter/material.dart';

import '../../../app/app_constant.dart';
import '../../../app/app_string.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  List<String> stages = [
    "ORDER PLACED",
    "ORDER ACCEPTED",
    "ORDER PICK UP IN PROGRESS",
    "ORDER ON THE WAY TO CUSTOMER",
    "ORDER ARRIVED",
    "ORDER DELIVERED"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppSpace(axis: Axis.vertical, percentage: .02),
            Text(
              AppString.appName,
              style: appStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const AppSpace(axis: Axis.vertical, percentage: .05),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final s = stages[index];
                return Row(
                  children: [
                    Text(s),
                  ],
                );
              },
              itemCount: stages.length,
            )
          ],
        ),
      ),
    ).callback(onTap: () => unFocus(context)));
  }
}
