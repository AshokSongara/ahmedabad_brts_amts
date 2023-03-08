import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/booking_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class BookingListUseCase implements UseCase<BookingListResponse, Params> {
  final UserRepository userRepository;

  BookingListUseCase(this.userRepository);

  @override
  Future<BookingListResponse> call(Params params) {
    return userRepository.getBookingListData();
  }
}
