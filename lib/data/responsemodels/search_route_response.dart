class SearchRouteResponse {
  List<Data>? data;
  bool? succeeded;

  SearchRouteResponse({this.data, this.succeeded});

  SearchRouteResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  String? journeyStartDate;
  String? journeyEndDate;
  String? startTime;
  String? endTime;
  String? totalTime;
  List<String>? routes;
  List<String>? interChanges;
  double? totalDistance;
  int? fare;
  List<RouteDetails>? routeDetails;

  Data(
      {this.journeyStartDate,
        this.journeyEndDate,
        this.startTime,
        this.endTime,
        this.totalTime,
        this.routes,
        this.interChanges,
        this.totalDistance,
        this.fare,
        this.routeDetails});

  Data.fromJson(Map<String, dynamic> json) {
    journeyStartDate = json['journeyStartDate'];
    journeyEndDate = json['journeyEndDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    totalTime = json['totalTime'];
    routes = json['routes'].cast<String>();
    interChanges = json['interChanges'].cast<String>();
    totalDistance = json['totalDistance'];
    fare = json['fare'];
    if (json['routeDetails'] != null) {
      routeDetails = <RouteDetails>[];
      json['routeDetails'].forEach((v) {
        routeDetails!.add(RouteDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['journeyStartDate'] = journeyStartDate;
    data['journeyEndDate'] = journeyEndDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['totalTime'] = totalTime;
    data['routes'] = routes;
    data['interChanges'] = interChanges;
    data['totalDistance'] = totalDistance;
    data['fare'] = fare;
    if (routeDetails != null) {
      data['routeDetails'] = routeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RouteDetails {
  String? startStopCode;
  String? endStopCode;
  String? startStopName;
  String? endStopName;
  String? startStopPosition;
  String? endStopPosition;
  String? routeCode;
  String? customerRouteCode;
  String? routeName;
  String? scheduleForRouteCode;
  int? startStopSequenceNumber;
  int? endStopSequenceNumber;
  double? distance;
  String? startArrivalTime;
  String? startDepartureTime;
  String? endArrivalTime;
  String? endDepartureTime;

  RouteDetails(
      {this.startStopCode,
        this.endStopCode,
        this.startStopName,
        this.endStopName,
        this.startStopPosition,
        this.endStopPosition,
        this.routeCode,
        this.customerRouteCode,
        this.routeName,
        this.scheduleForRouteCode,
        this.startStopSequenceNumber,
        this.endStopSequenceNumber,
        this.distance,
        this.startArrivalTime,
        this.startDepartureTime,
        this.endArrivalTime,
        this.endDepartureTime});

  RouteDetails.fromJson(Map<String, dynamic> json) {
    startStopCode = json['startStopCode'];
    endStopCode = json['endStopCode'];
    startStopName = json['startStopName'];
    endStopName = json['endStopName'];
    startStopPosition = json['startStopPosition'];
    endStopPosition = json['endStopPosition'];
    routeCode = json['routeCode'];
    customerRouteCode = json['customerRouteCode'];
    routeName = json['routeName'];
    scheduleForRouteCode = json['scheduleForRouteCode'];
    startStopSequenceNumber = json['startStopSequenceNumber'];
    endStopSequenceNumber = json['endStopSequenceNumber'];
    distance = json['distance'];
    startArrivalTime = json['startArrivalTime'];
    startDepartureTime = json['startDepartureTime'];
    endArrivalTime = json['endArrivalTime'];
    endDepartureTime = json['endDepartureTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startStopCode'] = startStopCode;
    data['endStopCode'] = endStopCode;
    data['startStopName'] = startStopName;
    data['endStopName'] = endStopName;
    data['startStopPosition'] = startStopPosition;
    data['endStopPosition'] = endStopPosition;
    data['routeCode'] = routeCode;
    data['customerRouteCode'] = customerRouteCode;
    data['routeName'] = routeName;
    data['scheduleForRouteCode'] = scheduleForRouteCode;
    data['startStopSequenceNumber'] = startStopSequenceNumber;
    data['endStopSequenceNumber'] = endStopSequenceNumber;
    data['distance'] = distance;
    data['startArrivalTime'] = startArrivalTime;
    data['startDepartureTime'] = startDepartureTime;
    data['endArrivalTime'] = endArrivalTime;
    data['endDepartureTime'] = endDepartureTime;
    return data;
  }
}