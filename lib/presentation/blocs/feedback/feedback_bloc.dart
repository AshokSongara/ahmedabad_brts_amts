import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/feddback_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackBloc extends Bloc<FeedbackEvent,FeedbackState>{
  FeedbackBloc(this.useCase):super(FeedbackInitialState());
  FeedbackUseCase useCase;
  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async*{
    if(event is FeedbackSubmitEvent){
      yield FeedbackLoadingState();
      FeedbackResponseModel model =await useCase(Params(data:event.model));
      if(model!=null){
        yield FeedbackResponseState(responseModel: model);
      }else{
        yield FeedbackErrorState();
      }

    }
  }
}