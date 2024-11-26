import 'package:equatable/equatable.dart';

class BusRoute extends Equatable {
  final String busNumber;
  final String fromLocation;
  final String toLocation;
  final String route;

  const BusRoute({
    required this.busNumber,
    required this.fromLocation,
    required this.toLocation,
    required this.route,
  });

  @override
  List<Object?> get props => [
    busNumber,
    fromLocation,
    toLocation,
    route
  ];
  Map<String, dynamic> toJson() {
    return {
      '_busNumber': busNumber,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'route': route,
    };
  }
}