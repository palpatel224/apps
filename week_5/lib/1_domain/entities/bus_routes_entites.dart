import 'package:hive/hive.dart';

part 'bus_routes_entites.g.dart';

@HiveType(typeId: 0)
class BusRoute {
  @HiveField(0)
  final String busNumber;

  @HiveField(1)
  final String fromLocation;

  @HiveField(2)
  final String toLocation;

  @HiveField(3)
  final String route;

  BusRoute({
    required this.busNumber,
    required this.fromLocation,
    required this.toLocation,
    required this.route,
  });
}