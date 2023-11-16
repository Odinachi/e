import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e/app/app_constant.dart';
import 'package:e/features/orders/data/domain/models/order_model.dart';
import 'package:e/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.fireStore) : super(OrderStatInit());
  final ran = Random();
  final FirebaseFirestore fireStore;
  Stream<QuerySnapshot> orderStream() => fireStore
      .collection('orders')
      .where("user_id", isEqualTo: globalAuthService.name)
      .snapshots();

  void addRandomOrder() async {
    await fireStore.collection('orders').add(OrderModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            userId: globalAuthService.name,
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

  void updateOrderStatus({required int status, required String docId}) async {
    await fireStore.collection('orders').doc(docId).update({'status': status});
  }

  void deleteOrder({required String docId}) async {
    await fireStore.collection('orders').doc(docId).delete();
  }
}
