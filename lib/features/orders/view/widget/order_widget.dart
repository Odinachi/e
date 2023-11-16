import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:e/app/app_assets.dart';
import 'package:e/app/app_colors.dart';
import 'package:e/app/app_constant.dart';
import 'package:e/app/app_string.dart';
import 'package:e/features/orders/data/domain/models/order_status_model.dart';
import 'package:e/features/orders/view/widget/status_widget.dart';
import 'package:e/features/orders/view_model/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/domain/models/order_model.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({super.key, this.order});
  final OrderModel? order;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool showDetails = false;

  List<OrderStatusModel> stages = [
    OrderStatusModel(
      title: "ORDER PLACED",
      time: DateTime.now(),
      desc: "Your order has been confirmed",
      image: AppAssets.cartIcon,
    ),
    OrderStatusModel(
      title: "ORDER ACCEPTED",
      time: DateTime.now(),
      desc: "Your good have been packaged and sent to the delivery station",
      image: AppAssets.handshakeIcon,
    ),
    OrderStatusModel(
        title: "ORDER PICK UP IN PROGRESS",
        time: DateTime.now(),
        desc: "Rider is picking up your order",
        image: AppAssets.progressIcon),
    OrderStatusModel(
      title: "ORDER ON THE WAY TO CUSTOMER",
      time: DateTime.now(),
      desc: "Rider is on the way",
      image: AppAssets.deliveryIcon,
    ),
    OrderStatusModel(
      title: "ORDER ARRIVED",
      time: DateTime.now(),
      desc: "Knock Knock, your rider is outside",
      image: AppAssets.arrivedIcon,
    ),
    OrderStatusModel(
      title: "ORDER DELIVERED",
      time: DateTime.now(),
      desc: "",
      image: AppAssets.deliveredIcon,
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    channelMessageSubscription?.cancel();
  }

  ably.RealtimeChannel? realtimeChannel;

  StreamSubscription<ably.Message>? channelMessageSubscription;

  final clientOptions = ably.ClientOptions(key: dotenv.get("ablyKey"));

  void listen() {
    channelMessageSubscription = realtimeChannel?.subscribe().listen((event) {
      final status = ((event.data as Map?)?['stage'] as int?) ?? 0;
      context
          .read<OrderCubit>()
          .updateOrderStatus(status: status, docId: widget.order?.docId ?? "");
      if (status >= 5) {
        realtimeChannel?.detach();
        channelMessageSubscription?.cancel();
      }
    });
  }

  Future<void> publish(int stage) async {
    await Future.delayed(const Duration(seconds: 10), () async {
      await realtimeChannel?.publish(
          message: ably.Message(
        data: {"stage": stage},
      ));
    });
  }

  void call() async {
    await publish(1);
    await publish(2);
    await publish(3);
    await publish(4);
    await publish(5);
  }

  @override
  void initState() {
    if ((widget.order?.status ?? 0) < 5) {
      realtimeChannel = ably.Realtime(options: clientOptions)
          .channels
          .get(widget.order?.id ?? "");
      listen();
      call();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double price = 0;
    widget.order?.items?.forEach((element) {
      price += ((element.price ?? 0) * (element.quantity ?? 0));
    });
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.black.withOpacity(.3))),
      child: Column(
        children: [
          _detailWidget(AppString.orderId, widget.order?.id ?? ""),
          _detailWidget(AppString.orderDate,
              getDate(widget.order?.createdAt ?? DateTime.now())),
          const AppSpace(
            percentage: .01,
          ),
          Text(
            AppString.orderItems,
            style: appStyle.copyWith(fontSize: 13),
            textAlign: TextAlign.start,
          ),
          const Divider(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppString.name,
                  style:
                      appStyle.copyWith(color: AppColors.black, fontSize: 13),
                ),
              ),
              Expanded(
                child: Text(
                  AppString.qty,
                  textAlign: TextAlign.center,
                  style:
                      appStyle.copyWith(color: AppColors.black, fontSize: 13),
                ),
              ),
              Expanded(
                child: Text(
                  AppString.price,
                  textAlign: TextAlign.right,
                  style:
                      appStyle.copyWith(color: AppColors.black, fontSize: 13),
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
          ),
          const AppSpace(
            percentage: .01,
          ),
          ListView.builder(
            itemBuilder: (_, index) {
              final each = widget.order?.items?[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        each?.name ?? "",
                        style: appStyle.copyWith(
                            color: AppColors.black, fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (each?.quantity ?? "").toString(),
                        textAlign: TextAlign.center,
                        style: appStyle.copyWith(
                            color: AppColors.black, fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$${each?.price?.toStringAsFixed(2)}",
                        textAlign: TextAlign.right,
                        style: appStyle.copyWith(
                            color: AppColors.black, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: (widget.order?.items?.length ?? 0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
          const Divider(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppString.total,
                  style:
                      appStyle.copyWith(color: AppColors.black, fontSize: 13),
                ),
              ),
              Expanded(
                child: Text(
                  "\$${price.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                  style:
                      appStyle.copyWith(color: AppColors.black, fontSize: 13),
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
          ),
          const AppSpace(
            percentage: .01,
          ),
          Text(
            AppString.orderStatus,
            style: appStyle.copyWith(fontSize: 13),
            textAlign: TextAlign.start,
          ),
          const AppSpace(
            percentage: .01,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: showDetails
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final s = stages[index];
                      final currentStatus = (widget.order?.status ?? 0);
                      return StatusWidget(
                        model: s,
                        status: currentStatus == index
                            ? Status.current
                            : currentStatus > index
                                ? Status.passed
                                : Status.future,
                      );
                    },
                    itemCount: stages.length,
                  )
                : StatusWidget(
                    model: stages[widget.order?.status ?? 0],
                    status: Status.current,
                  ).callback(
                    onTap: () => setState(() {
                          showDetails = !showDetails;
                        })),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.trackYourOrder,
                  style:
                      appStyle.copyWith(color: AppColors.black, fontSize: 13),
                ),
                Icon(
                  showDetails ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 30,
                ),
              ],
            ).callback(
                onTap: () => setState(() {
                      showDetails = !showDetails;
                    })),
          )
        ],
      ),
    );
  }

  Widget _detailWidget(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: appStyle.copyWith(fontSize: 13),
          ),
          Text(
            value,
            style: appStyle.copyWith(fontSize: 13, color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
