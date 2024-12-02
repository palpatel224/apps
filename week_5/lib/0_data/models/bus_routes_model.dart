import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

class BusRouteModel extends BusRoute {
  BusRouteModel({
    required super.busNumber,
    required super.fromLocation,
    required super.toLocation,
    required super.route,
  });

  factory BusRouteModel.fromJson(Map<String, dynamic> json) {
    String cleanRoute = (json['route'] as String)
        .replaceAll('–', '→') 
        .replaceAll('-', '→') 
        .replaceAll('.', '')   
        .trim();

    return BusRouteModel(
      busNumber: json['bus_number'] as String,
      fromLocation: json['from_location'] as String,
      toLocation: json['to_location'] as String,
      route: cleanRoute,
    );
  }

  static List<BusRouteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BusRouteModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}