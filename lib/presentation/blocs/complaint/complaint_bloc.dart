import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/complaint_routes_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/complaint_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/complaint_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint/complaint_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint/complaint_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc(this.complaintGetStopUseCase, this.brtsStopResponseModel,
      this.complaintGetRoutesUseCase, this.complaintUserUseCase) :super(ComplaintInitialState());

  ComplaintGetStopUseCase complaintGetStopUseCase;
  BrtsStopResponseModel? brtsStopResponseModel;
  ComplaintGetRoutesUseCase complaintGetRoutesUseCase;
  ComplaintUserUseCase complaintUserUseCase;


  @override
  Stream<ComplaintState> mapEventToState(ComplaintEvent event) async* {
    if (event is GetAvailableStopsEvent) {
      yield ComplaintLoadingState();
      BrtsStopResponseModel data = await complaintGetStopUseCase.call(
          Params(data: event.model));
      print("GetAvailableStopsEvent data.data?.length ${data.data?.length}");
      brtsStopResponseModel = data;
      yield StopsResponseState(data);
    }
    if (event is GetAvailableRoutesEvent) {
      var data = await complaintGetRoutesUseCase.call(
          Params(data: event.model));
      print(" GetAvailableRoutesEvent data.data?.length ${data.data?.length}");
      yield RoutesResponseState(data);
      yield StopsResponseState(brtsStopResponseModel!);
    }
    if (event is ComplaintUserEvent) {
      yield ComplaintLoadingState();
      ComplaintResponseModel complaintResponseModel =
      await complaintUserUseCase(Params(data: event.data));
      if (complaintResponseModel.succeeded == true) {
        yield ComplaintSuccessState(complaintResponseModel: complaintResponseModel);
      } else {
        yield ComplaintFailedState();
      }
    }
  }
}