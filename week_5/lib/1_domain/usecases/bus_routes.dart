import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';

class BusRoutesUseCase {
  final BusRouteRepository repository;

  BusRoutesUseCase(this.repository);

  Future<BusRoute> searchByBusNumber(String busNumber) async {
    return await repository.searchByBusNumber(busNumber);
  }
}