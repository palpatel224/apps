import 'package:week_5/0_data/repositories/busroute_repo_impl.dart';
import 'package:week_5/bus_routes.dart';

class BusRoutesRepository {
  final BusRoutesApiService _apiService;
  BusRoutesRepository(this._apiService);
  Future<List<BusRoute>> getBusRoutes(int page, int limit) async {
    try{
      final routes  = await _apiService.fetchBusRoutes(page: page, limit: limit);
      return routes;
    }catch (error){
      throw Exception('Failed to fetch bus Routes: $error');
    }
  }
}