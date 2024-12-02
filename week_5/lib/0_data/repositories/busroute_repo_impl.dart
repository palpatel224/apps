import 'package:week_5/0_data/datasources/remote_datasource.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';

class BusRouteRepositoryImpl implements BusRouteRepository {
  final BusRouteRemoteDataSource remoteDataSource;

  BusRouteRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<BusRoute>> getAllBusRoutes(int page, int size) async {
    return await remoteDataSource.fetchAllBusRoutes(page, size);
  }

  @override
  Future<List<BusRoute>> searchBusRoutes(String? fromLocation, String? toLocation) async {
    return await remoteDataSource.searchBusRoutes(fromLocation, toLocation);
  }

  @override
  Future<BusRoute> getRouteDetails(String busNumber) async {
    return await remoteDataSource.fetchRouteDetails(busNumber);
  }
    @override
  Future<BusRoute> searchByBusNumber(String busNumber) async {
    return await remoteDataSource.fetchRouteDetails(busNumber);
  }  
}