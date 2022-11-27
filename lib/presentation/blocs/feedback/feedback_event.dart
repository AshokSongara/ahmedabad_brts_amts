import 'package:ahmedabad_brts_amts/data/requestmodels/feedback_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}
class FeedbackSubmitEvent extends FeedbackEvent{
  FeedbackRequestModel model;
  FeedbackSubmitEvent(this.model);
}