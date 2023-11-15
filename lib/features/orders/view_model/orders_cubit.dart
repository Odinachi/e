import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.fireStore) : super(OrderStatInit());

  final FirebaseFirestore fireStore;
  Stream<QuerySnapshot> orderStream() =>
      fireStore.collection('orders').snapshots();
}
