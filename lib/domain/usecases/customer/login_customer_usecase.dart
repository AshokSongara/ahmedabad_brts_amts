import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/models/login_response.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/customer/customer_repository.dart';

class LoginCustomerUseCase implements UseCase<LoginResponse, Params> {
  final CustomerRepository customerRepository;

  LoginCustomerUseCase(this.customerRepository);

  @override
  Future<LoginResponse> call(Params params) {
    return customerRepository.registerUser(params.data);
  }
}


