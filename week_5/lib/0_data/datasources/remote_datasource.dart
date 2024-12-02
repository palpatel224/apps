import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week_5/0_data/models/bus_routes_model.dart';

class BusRouteRemoteDataSource {
  final http.Client client;

  BusRouteRemoteDataSource(this.client);

  Future<List<BusRouteModel>> fetchAllBusRoutes(int page, int size) async {
    final response = await client.get(Uri.parse(
        'https://app-bootcamp.iris.nitk.ac.in/bus_routes/?page=$page&size=$size'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BusRouteModel.fromJsonList(data['routes']);
    } else {
      throw Exception('Failed to load bus routes');
    }
  }

  Future<List<BusRouteModel>> searchBusRoutes(
      String? fromLocation, String? toLocation) async {
    final url = Uri.parse(
        'https://app-bootcamp.iris.nitk.ac.in/bus_routes/search/?${fromLocation != null ? 'from_location=$fromLocation&' : ''}${toLocation != null ? 'to_location=$toLocation' : ''}');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return BusRouteModel.fromJsonList(json.decode(response.body));
    } else {
      throw Exception('No matching routes found');
    }
  }

  Future<BusRouteModel> fetchRouteDetails(String busNumber) async {
    final response = await client.get(Uri.parse(
        'https://app-bootcamp.iris.nitk.ac.in/bus_routes/$busNumber'));

    if (response.statusCode == 200) {
      return BusRouteModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Bus route not found');
    }
  }
}
