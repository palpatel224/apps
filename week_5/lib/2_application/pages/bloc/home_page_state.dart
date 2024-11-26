// bloc/bus_routes_state.dart
import 'package:week_5/bus_routes.dart';

enum BusRouteStatus { initial, loading, success, failure }

class BusRoutesState {
  final BusRouteStatus status;
  final List<BusRoute> routes;
  final String? error;
  final bool hasReachedMax;

  BusRoutesState({
    this.status = BusRouteStatus.initial,
    this.routes = const [],
    this.error,
    this.hasReachedMax = false,
  });

  BusRoutesState copyWith({
    BusRouteStatus? status,
    List<BusRoute>? routes,
    String? error,
    bool? hasReachedMax,
  }) {
    return BusRoutesState(
      status: status ?? this.status,
      routes: routes ?? this.routes,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax?? this.hasReachedMax,
    );
  }
}