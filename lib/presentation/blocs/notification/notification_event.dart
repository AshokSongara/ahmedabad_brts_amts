import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends NotificationEvent {
  const GetNotificationEvent();

  @override
  List<Object> get props => [];
}
