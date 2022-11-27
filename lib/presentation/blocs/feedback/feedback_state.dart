import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}
class FeedbackInitialState extends FeedbackState{}
class FeedbackLoadingState extends FeedbackState{}
class FeedbackResponseState extends FeedbackState{
  FeedbackResponseModel responseModel;
  FeedbackResponseState({required this.responseModel});
}
class FeedbackErrorState extends FeedbackState{}
