import 'package:e/app/app_assets.dart';
import 'package:e/app/app_constant.dart';
import 'package:e/features/orders/data/domain/models/order_model.dart';
import 'package:e/features/orders/view/order_screen.dart';
import 'package:e/features/orders/view/widget/status_widget.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({super.key});

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
        desc: "",
        image: AppAssets.progressIcon),
    OrderStatusModel(
      title: "ORDER ON THE WAY TO CUSTOMER",
      time: DateTime.now(),
      desc: "",
      image: AppAssets.deliveryIcon,
    ),
    OrderStatusModel(
      title: "ORDER ARRIVED",
      time: DateTime.now(),
      desc: "",
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: showDetails
              ? ListView.builder(
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
              : StatusWidget(
                  model: stages.first,
                  status: Status.current,
                ).callback(
                  onTap: () => setState(() {
                        showDetails = !showDetails;
                      })),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Icon(
            showDetails ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 30,
          ).callback(
              onTap: () => setState(() {
                    showDetails = !showDetails;
                  })),
        )
      ],
    );
  }
}
