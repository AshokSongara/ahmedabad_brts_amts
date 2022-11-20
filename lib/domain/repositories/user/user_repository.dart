
import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';

abstract class UserRepository {
  Future<SignUpResponse> signupUser(SignupRequest body);
  Future<SignUpResponse> loginUser(dynamic body);
}
