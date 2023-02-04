import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/qr_code_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class QRUserUseCase implements UseCase<QRCodeResponse, Params> {
  final UserRepository userRepository;

  QRUserUseCase(this.userRepository);

  @override
  Future<QRCodeResponse> call(Params params) {
    return userRepository.getQRCodeData();
  }
}
