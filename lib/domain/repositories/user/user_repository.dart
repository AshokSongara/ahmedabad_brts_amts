import 'package:ahmedabad_brts_amts/data/models/login_response.dart';

abstract class UserRepository {
  Future<LoginResponse> registerUser(dynamic body);
  Future<LoginResponse> loginUser(dynamic body);
}
