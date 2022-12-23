import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final NotificationResponse notificationResponse;

  NotificationSuccessState({required this.notificationResponse});

  @override
  List<Object> get props => [notificationResponse];
}

class NotificationFailedState extends NotificationState {
  final String errorMessage;

  NotificationFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
