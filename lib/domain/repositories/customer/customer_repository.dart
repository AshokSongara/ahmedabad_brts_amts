import 'package:ahmedabad_brts_amts/data/models/login_response.dart';

abstract class CustomerRepository {
  Future<LoginResponse> loginUser(Map<String,String> body);
}
