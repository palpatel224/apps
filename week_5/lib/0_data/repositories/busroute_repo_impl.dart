import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week_5/bus_routes.dart';

class BusRoutesApiService {
  static const baseUrl = 'https://app-bootcamp.iris.nitk.ac.in';

  Future<List<BusRoute>> fetchBusRoutes({
    required int page,
    required int limit,
    String? searchQuery,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/bus_routes').replace(
        queryParameters: {
          'page': page.toString(),
          'limit': limit.toString(),
          if (searchQuery != null) 'search': searchQuery,
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> routesJson = responseBody['routes'] ?? [];
        return routesJson.map((json) => _parseRouteFromJson(json)).toList();
      } else {
        throw Exception('Failed to load bus routes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  BusRoute _parseRouteFromJson(Map<String, dynamic> json) {
    return BusRoute(
      busNumber: json['bus_number']?.toString() ?? '',
      fromLocation: json['from_location'] ?? 'Unknown',
      toLocation: json['to_location'] ?? 'Unknown',
      route: json['route'] ?? 'General',
    );
  }
}