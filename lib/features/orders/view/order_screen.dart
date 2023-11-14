import 'package:e/app/app_assets.dart';
import 'package:e/app/app_colors.dart';
import 'package:e/features/orders/data/domain/models/order_model.dart';
import 'package:flutter/material.dart';

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
  }

  List<OrderModel> stages = [
    OrderModel(
      title: "ORDER PLACED",
      time: DateTime.now(),
      desc: "Your order has been confirmed",
      image: AppAssets.cartIcon,
    ),
    OrderModel(
      title: "ORDER ACCEPTED",
      time: DateTime.now(),
      desc: "Your good have been packaged and sent to the delivery station",
      image: AppAssets.handshakeIcon,
    ),
    OrderModel(
        title: "ORDER PICK UP IN PROGRESS",
        time: DateTime.now(),
        desc: "",
        image: AppAssets.progressIcon),
    OrderModel(
      title: "ORDER ON THE WAY TO CUSTOMER",
      time: DateTime.now(),
      desc: "",
      image: AppAssets.deliveryIcon,
    ),
    OrderModel(
      title: "ORDER ARRIVED",
      time: DateTime.now(),
      desc: "",
      image: AppAssets.arrivedIcon,
    ),
    OrderModel(
      title: "ORDER DELIVERED",
      time: DateTime.now(),
      desc: "",
      image: AppAssets.deliveredIcon,
    ),
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
            const AppSpace(axis: Axis.vertical, percentage: .05),
            Text(
              "Hi, name",
              style: appStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
              textAlign: TextAlign.start,
            ),
            const AppSpace(axis: Axis.vertical, percentage: .05),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final s = stages[index];

                return StatusWidget(
                  model: s,
                  status: Status.current,
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

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.model,
    this.status = Status.future,
  });

  final OrderModel model;
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: status == Status.passed ? 0.3 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryColor,
            ),
            color: status == Status.current ? AppColors.primaryColor : null,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            AppImageBuilder(
              path: model.image ?? "",
              fit: BoxFit.cover,
              color: status == Status.current
                  ? AppColors.white
                  : AppColors.primaryColor,
              height: 30,
              width: 30,
            ),
            const AppSpace(
              axis: Axis.horizontal,
              percentage: .04,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: model.title,
                      children: [
                        TextSpan(
                          text:
                              " (${DateTime.now().difference(model.time ?? DateTime.now()).inMinutes} mins ago)",
                          style: appStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: status == Status.current
                                ? AppColors.white.withOpacity(.8)
                                : AppColors.hintGrey,
                          ),
                        ),
                      ],
                      style: appStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color:
                            status == Status.current ? AppColors.white : null,
                      ),
                    ),
                  ),
                  if (model.desc?.isNotEmpty ?? false)
                    Text(
                      model.desc ?? "",
                      style: appStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: status == Status.current
                            ? AppColors.white.withOpacity(.8)
                            : AppColors.hintGrey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Status { passed, current, future }
