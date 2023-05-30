import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_history_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/complaint_history_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint_history/complaint_history_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint_history/complaint_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintHistoryBloc extends Bloc<ComplaintHistoryEvent, ComplaintHistoryState> {
  ComplaintHistoryBloc({required this.complaintHistoryUseCase})
      : super(ComplaintHistoryInitialState());

  final ComplaintHistoryUseCase complaintHistoryUseCase;

  @override
  Stream<ComplaintHistoryState> mapEventToState(ComplaintHistoryEvent event) async* {
    if (event is GetComplaintHistoryEvent) {
      yield ComplaintHistoryLoadingState();
      ComplaintHistoryResponse complaintHistoryResponse =
      await complaintHistoryUseCase(Params(data: ""));
      if (complaintHistoryResponse.succeeded == true) {
        yield ComplaintHistorySuccessState(complaintHistoryResponse: complaintHistoryResponse);
      } else {
        yield const ComplaintHistoryFailedState(
            errorMessage: "Something Went Wrong");
      }
    }
  }
}