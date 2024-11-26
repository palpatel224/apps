// route_details_page.dart
import 'package:flutter/material.dart';
import 'package:week_5/bus_routes.dart';

class RouteDetailsPage extends StatelessWidget {
  final BusRoute route;

  const RouteDetailsPage({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route ${route.busNumber} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bus Number: ${route.busNumber}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('From: ${route.fromLocation}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('To: ${route.toLocation}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}