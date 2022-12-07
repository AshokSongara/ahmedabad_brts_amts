import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/mobile_number_login_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileNumberLoginBloc
    extends Bloc<MobileNumberLoginEvent, MobileNumberLoginState> {
  final MobileNumberLoginUseCase useCase;

  MobileNumberLoginBloc(this.useCase) : super(MobileNumberLoginInitialState());

  @override
  Stream<MobileNumberLoginState> mapEventToState(
      MobileNumberLoginEvent event) async* {
    if (event is PhoneNumberSubmitEvent) {
      yield MobileNumberLoadingState();
      if (event.phoneNumber.length != 10) {
        yield MobileNumberValidationErrorState();
      } else {
        final response = await useCase
            .call(MobileNumberOtpRequestParam(phoneNumber: event.phoneNumber));
        if (response.statusCode == true) {
          yield MobileNumberLoginSuccessState();
        } else {
          yield MobileNumberLoginErrorState();
        }
      }
    }
  }
}
