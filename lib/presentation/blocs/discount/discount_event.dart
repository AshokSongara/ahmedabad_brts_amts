import 'package:equatable/equatable.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class GetDiscountEvent extends DiscountEvent {
  const GetDiscountEvent();

  @override
  List<Object> get props => [];
}
