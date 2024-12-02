
import 'package:equatable/equatable.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

abstract class BusRoutesState extends Equatable {
  @override
  List<Object> get props => [];
}

class BusRoutesInitial extends BusRoutesState {}

class BusRoutesLoading extends BusRoutesState {}

class BusRoutesLoaded extends BusRoutesState {
  final List<BusRoute> routes;

  BusRoutesLoaded(this.routes);

  @override
  List<Object> get props => [routes];
}

class RouteDetailsLoaded extends BusRoutesState {
  final BusRoute routeDetails;

  RouteDetailsLoaded(this.routeDetails);

  @override
  List<Object> get props => [routeDetails];
}

class BusRoutesError extends BusRoutesState {
  final String message;

  BusRoutesError(this.message);

  @override
  List<Object> get props => [message];
}

class BusRouteFound extends BusRoutesState{
  final BusRoute route;
  BusRouteFound(this.route);
}