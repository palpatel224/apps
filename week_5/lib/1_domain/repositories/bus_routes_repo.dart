import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

abstract class BusRouteRepository {
  Future<List<BusRoute>> getAllBusRoutes(int page, int size);

  Future<List<BusRoute>> searchBusRoutes(
      String? fromLocation, String? toLocation);

  Future<BusRoute> getRouteDetails(String busNumber);

  Future<BusRoute> searchByBusNumber(String busNumber);
}
