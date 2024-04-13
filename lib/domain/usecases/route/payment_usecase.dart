import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/payment_URL_Response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class PaymentUseCase implements UseCase<PaymentURLResponse, Params> {
  final UserRepository userRepository;

  PaymentUseCase(this.userRepository);

  @override
  Future<PaymentURLResponse> call(Params params) {
    return userRepository.getPaymentUrl(params.data);
  }
}
