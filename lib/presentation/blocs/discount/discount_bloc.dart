import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/discount_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/one_day_pass_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/discount_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/oneday_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc({required this.discountUseCase}) : super(DiscountInitialState());

  final DiscountUseCase discountUseCase;

  @override
  Stream<DiscountState> mapEventToState(DiscountEvent event) async* {
    if (event is GetDiscountEvent) {
      yield DiscountLoadingState();
      DiscountResponse discountResponse =
          await discountUseCase(Params(data: ""));
      if (discountResponse.succeeded == true) {
        yield DiscountSuccessState(discountResponse: discountResponse);
      } else {
        yield DiscountFailedState();
      }
    }
  }
}
