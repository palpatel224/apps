import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';

class GetAllBusRoutes {
  final BusRouteRepository repository;
  GetAllBusRoutes(this.repository);
  Future<List<BusRoute>> execute(int page, int size) async {
    return await repository.getAllBusRoutes(page, size);
  }
}
