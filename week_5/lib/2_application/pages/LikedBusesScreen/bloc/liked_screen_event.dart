import 'package:equatable/equatable.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

abstract class LikedBusesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLikedBuses extends LikedBusesEvent {}

class DeleteLikedBus extends LikedBusesEvent {
  final int index;
  final BusRoute busRoute;

  DeleteLikedBus({required this.index, required this.busRoute});

  @override
  List<Object> get props => [index, busRoute];
}