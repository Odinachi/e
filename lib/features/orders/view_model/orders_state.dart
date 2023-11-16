part of 'orders_cubit.dart';

abstract class OrderState extends Equatable {}

class OrderStatInit extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderStatLoading extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderStateSuccessful extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderStatFailed extends OrderState {
  final String error;
  OrderStatFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
