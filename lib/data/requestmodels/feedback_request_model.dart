/// routeId : "4D"
/// waiting : 1
/// comfort : 2
/// crowding : 1
/// serviceQuality : 2
/// journey : "AtoB"
/// userId : 6

class FeedbackRequestModel {
  FeedbackRequestModel({
    String? routeId,
    int? waiting,
    int? comfort,
    int? crowding,
    int? serviceQuality,
    String? journey,
    int? userId,
    int? assistance,
    int? paymentMode,
    int? suggestion,
  }) {
    _routeId = routeId;
    _waiting = waiting;
    _comfort = comfort;
    _crowding = crowding;
    _serviceQuality = serviceQuality;
    _journey = journey;
    _userId = userId;
    _assistance = assistance;
    _paymentMode = paymentMode;
    _suggestion = suggestion;
  }

  FeedbackRequestModel.fromJson(dynamic json) {
    _routeId = json['routeId'];
    _waiting = json['waiting'];
    _comfort = json['comfort'];
    _crowding = json['crowding'];
    _serviceQuality = json['serviceQuality'];
    _journey = json['journey'];
    _userId = json['userId'];
    _assistance = json['assistance'];
    _paymentMode = json['paymentMode'];
    _suggestion = json['suggestion'];
  }

  String? _routeId;
  int? _waiting;
  int? _comfort;
  int? _crowding;
  int? _serviceQuality;
  String? _journey;
  int? _userId;
  int? _assistance;
  int? _paymentMode;
  int? _suggestion;

  FeedbackRequestModel copyWith({
    String? routeId,
    int? waiting,
    int? comfort,
    int? crowding,
    int? serviceQuality,
    String? journey,
    int? userId,
    int? assistance,
    int? paymentMode,
    int? suggestion,
  }) =>
      FeedbackRequestModel(
        routeId: routeId ?? _routeId,
        waiting: waiting ?? _waiting,
        comfort: comfort ?? _comfort,
        crowding: crowding ?? _crowding,
        serviceQuality: serviceQuality ?? _serviceQuality,
        journey: journey ?? _journey,
        userId: userId ?? _userId,
        assistance: userId ?? _assistance,
        paymentMode: userId ?? _paymentMode,
        suggestion: userId ?? _suggestion,
      );

  String? get routeId => _routeId;

  int? get waiting => _waiting;

  int? get comfort => _comfort;

  int? get crowding => _crowding;

  int? get serviceQuality => _serviceQuality;

  String? get journey => _journey;

  int? get userId => _userId;

  int? get assistance => _assistance;

  int? get paymentMode => _paymentMode;

  int? get suggestion => _suggestion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routeId'] = _routeId;
    map['waiting'] = _waiting;
    map['comfort'] = _comfort;
    map['crowding'] = _crowding;
    map['serviceQuality'] = _serviceQuality;
    map['journey'] = _journey;
    map['userId'] = _userId;
    map['assistance'] = _assistance;
    map['paymentMode'] = _paymentMode;
    map['suggestion'] = _suggestion;
    return map;
  }
}
