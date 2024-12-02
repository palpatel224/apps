
import 'package:equatable/equatable.dart';

abstract class BusRoutesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllBusRoutes extends BusRoutesEvent {
  final int page;
  final int size;

  FetchAllBusRoutes(this.page, this.size);

  @override
  List<Object> get props => [page, size];
}

class SearchForBusRoutes extends BusRoutesEvent {
  final String fromLocation;
  final String toLocation;

  SearchForBusRoutes(this.fromLocation, this.toLocation);

  @override
  List<Object> get props => [fromLocation, toLocation];
}

class FetchRouteDetails extends BusRoutesEvent {
  final String busNumber;

  FetchRouteDetails(this.busNumber);

  @override
  List<Object> get props => [busNumber];
}

class SearchBusByNumber extends BusRoutesEvent {
  final String busNumber;
  SearchBusByNumber({required this.busNumber});
}

