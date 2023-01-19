class RouteDetailsRequest {
  String? routeCode;
  String? startCode;
  String? endCode;
  String? fromHome;
  String? originStart;
  String? originEnd;
  String? serviceType;

  RouteDetailsRequest(
      {this.routeCode,
      this.startCode,
      this.endCode,
      this.fromHome,
      this.originStart,
      this.originEnd,
      this.serviceType});
}
