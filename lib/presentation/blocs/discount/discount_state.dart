import 'package:ahmedabad_brts_amts/data/responsemodels/discount_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/one_day_pass_response.dart';

abstract class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

class DiscountInitialState extends DiscountState {}

class DiscountLoadingState extends DiscountState {}

class DiscountSuccessState extends DiscountState {
  final DiscountResponse discountResponse;

  DiscountSuccessState({required this.discountResponse});

  @override
  List<Object> get props => [discountResponse];
}

class DiscountFailedState extends DiscountState {}
