import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';
import '../../../data/responsemodels/PaymentInitResponseModel.dart';

class AddTransactionUseCase implements UseCase<PaymentInitResponseModel, Params> {
  final UserRepository userRepository;

  AddTransactionUseCase(this.userRepository);

  @override
  Future<PaymentInitResponseModel> call(Params params) {
    return userRepository.addTransaction(params.data);
  }
}
