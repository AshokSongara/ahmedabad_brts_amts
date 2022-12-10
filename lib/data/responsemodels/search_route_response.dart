class SearchRouteResponse {
  List<Data>? data;
  bool? succeeded;

  SearchRouteResponse({this.data, this.succeeded});

  SearchRouteResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['succeeded'] = this.succeeded;
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
        routeDetails!.add(new RouteDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['journeyStartDate'] = this.journeyStartDate;
    data['journeyEndDate'] = this.journeyEndDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['totalTime'] = this.totalTime;
    data['routes'] = this.routes;
    data['interChanges'] = this.interChanges;
    data['totalDistance'] = this.totalDistance;
    data['fare'] = this.fare;
    if (this.routeDetails != null) {
      data['routeDetails'] = this.routeDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startStopCode'] = this.startStopCode;
    data['endStopCode'] = this.endStopCode;
    data['startStopName'] = this.startStopName;
    data['endStopName'] = this.endStopName;
    data['startStopPosition'] = this.startStopPosition;
    data['endStopPosition'] = this.endStopPosition;
    data['routeCode'] = this.routeCode;
    data['customerRouteCode'] = this.customerRouteCode;
    data['routeName'] = this.routeName;
    data['scheduleForRouteCode'] = this.scheduleForRouteCode;
    data['startStopSequenceNumber'] = this.startStopSequenceNumber;
    data['endStopSequenceNumber'] = this.endStopSequenceNumber;
    data['distance'] = this.distance;
    data['startArrivalTime'] = this.startArrivalTime;
    data['startDepartureTime'] = this.startDepartureTime;
    data['endArrivalTime'] = this.endArrivalTime;
    data['endDepartureTime'] = this.endDepartureTime;
    return data;
  }
}