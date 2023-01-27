class RouteDetailsRequest {
  String? routeCode;
  String? startCode;
  String? endCode;
  String? fromHome;
  String? originStart;
  String? originEnd;
  String? serviceType;
  String? routeTwo;
  String? startRouteTwo;
  String? endRouteTwo;

  RouteDetailsRequest(
      {this.routeCode,
      this.startCode,
      this.endCode,
      this.fromHome,
      this.originStart,
      this.originEnd,
      this.serviceType,
      this.routeTwo,
      this.startRouteTwo,
      this.endRouteTwo,
      });
}
