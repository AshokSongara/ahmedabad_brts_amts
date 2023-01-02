import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';

abstract class NearByMapState{}
class NearByMapInitialState extends NearByMapState{}
class NearByMapLoadingState extends NearByMapState{}
class NearByMapFailState extends NearByMapState{}
class NearByMapSuccessState extends NearByMapState{
  NearMeResponse nearMeResponse;
  NearByMapSuccessState({required this.nearMeResponse});
}