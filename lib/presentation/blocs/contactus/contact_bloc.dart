import 'dart:async';

import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/contactus_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/contactus_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/contactus/contact_state.dart';
import 'package:bloc/bloc.dart';

import 'contact_event.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc({required this.contactUsUseCase}) : super(ContactInitialState());

  final ContactUsUseCase contactUsUseCase;

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is GetContactEvent) {
      yield ContactLoadingState();
      ContactUsResponse contactUsResponse =
          await contactUsUseCase(Params(data: ""));
      if (contactUsResponse.succeeded == true) {
        yield ContactSuccessState(contactUsResponse: contactUsResponse);
      } else {
        yield ContactFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
