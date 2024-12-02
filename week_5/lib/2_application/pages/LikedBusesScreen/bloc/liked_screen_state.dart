import 'package:equatable/equatable.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

abstract class LikedBusesState extends Equatable {
  @override
  List<Object> get props => [];
}

class LikedBusesInitial extends LikedBusesState {}

class LikedBusesLoading extends LikedBusesState {}

class LikedBusesLoaded extends LikedBusesState {
  final List<BusRoute> likedBuses;

  LikedBusesLoaded(this.likedBuses);

  @override
  List<Object> get props => [likedBuses];
}

class LikedBusesError extends LikedBusesState {
  final String message;

  LikedBusesError(this.message);

  @override
  List<Object> get props => [message];
}