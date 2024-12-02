import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

abstract class BusRouteDetailsState {}

class BusRouteDetailsInitial extends BusRouteDetailsState {}
class BusRouteDetailsLoading extends BusRouteDetailsState {}
class BusRouteDetailsLoaded extends BusRouteDetailsState {
  final BusRoute routeDetails;
  BusRouteDetailsLoaded(this.routeDetails);
}
class BusRouteDetailsError extends BusRouteDetailsState {
  final String message;
  BusRouteDetailsError(this.message);
}