import 'package:e/app/app_colors.dart';
import 'package:e/app/app_string.dart';
import 'package:e/features/orders/data/domain/models/order_model.dart';
import 'package:e/features/orders/view/widget/order_widget.dart';
import 'package:e/features/orders/view_model/orders_cubit.dart';
import 'package:e/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_constant.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<OrderCubit>().addRandomOrder();
          },
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
                Expanded(
                  child: StreamBuilder(
                      stream: context.read<OrderCubit>().orderStream(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        if (snapshot.data?.docs.isEmpty == true) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppString.useThe,
                                style: appStyle.copyWith(
                                    color: AppColors.hintGrey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemBuilder: (_, index) {
                            final each = OrderModel.fromJson(
                                snapshot.data?.docs[index].data()
                                    as Map<String, dynamic>);
                            return OrderItemWidget(
                              order: each,
                            );
                          },
                          itemCount: snapshot.data?.docs.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) =>
                              const AppSpace(
                            percentage: .02,
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ).callback(onTap: () => unFocus(context)));
  }
}
