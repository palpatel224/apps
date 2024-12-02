abstract class BusRouteDetailsEvent {}

class FetchRouteDetails extends BusRouteDetailsEvent {
  final String busNumber;
  FetchRouteDetails(this.busNumber);
}