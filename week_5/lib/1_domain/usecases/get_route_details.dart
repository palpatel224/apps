import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';

class GetRouteDetails {
  final BusRouteRepository repository;
  GetRouteDetails(this.repository);
  Future<BusRoute> execute(String busNumber) async {
    return await repository.getRouteDetails(busNumber);
  }
}