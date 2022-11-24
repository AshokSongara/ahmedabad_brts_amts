import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';

abstract class RouteRepository {
  Future<NearMeResponse> nearMe(NearMeRequest body);
}
