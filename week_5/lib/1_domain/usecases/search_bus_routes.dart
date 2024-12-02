import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';

class SearchBusRoutes {
  final BusRouteRepository repository;
  SearchBusRoutes(this.repository);
  Future<List<BusRoute>> execute(String? fromLocation, String? toLocation) async {
    return await repository.searchBusRoutes(fromLocation, toLocation);
  }
}