part of 'orders_cubit.dart';

abstract class OrderState {}

class OrderStatInit extends OrderState {}

class OrderStatLoading extends OrderState {}

class OrderStateSuccessful extends OrderState {}

class OrderStatFailed extends OrderState {
  final String error;
  OrderStatFailed({required this.error});
}
