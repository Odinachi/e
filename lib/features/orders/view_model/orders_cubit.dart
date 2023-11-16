import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e/app/app_constant.dart';
import 'package:e/features/orders/data/domain/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.fireStore) : super(OrderStatInit());
  final ran = Random();
  final FirebaseFirestore fireStore;
  Stream<QuerySnapshot> orderStream() =>
      fireStore.collection('orders').snapshots();

  void addRandomOrder() async {
    await fireStore.collection('orders').add(OrderModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            items: List<Item>.generate(
                (ran.nextInt(4) + 2),
                (index) => Item(
                    name: foods[ran.nextInt(foods.length)],
                    price: 20.0 + ran.nextDouble() * (5.0 - 2.0),
                    quantity: (ran.nextInt(4) + 2))),
            createdAt: DateTime.now(),
            status: 0)
        .toJson());
  }
}
