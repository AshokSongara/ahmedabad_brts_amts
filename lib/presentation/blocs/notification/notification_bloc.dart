import 'dart:async';

import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/notification_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/notification/notification_state.dart';
import 'package:bloc/bloc.dart';

import 'notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required this.notificationUseCase})
      : super(NotificationInitialState());

  final NotificationUseCase notificationUseCase;

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is GetNotificationEvent) {
      yield NotificationLoadingState();
      NotificationResponse notificationResponse =
          await notificationUseCase(Params(data: ""));
      if (notificationResponse.succeeded == true) {
        yield NotificationSuccessState(
            notificationResponse: notificationResponse);
      } else {
        yield NotificationFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
