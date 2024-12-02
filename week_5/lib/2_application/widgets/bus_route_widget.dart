import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';

class BusRouteCard extends StatelessWidget {
  final BusRoute route;

  const BusRouteCard({super.key, required this.route});

  bool _isAlreadyLiked(Box<BusRoute> box, String busNumber) {
    return box.values.any((route) => route.busNumber == busNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(route.busNumber),
        subtitle: Text("${route.fromLocation} - ${route.toLocation}"),
        trailing: IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () async {
            final box = Hive.box<BusRoute>('busRoutes');

            if (_isAlreadyLiked(box, route.busNumber)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bus route already liked!'),
                  duration: Duration(milliseconds: 100),
                ),
              );
              return;
            }

            await box.add(route);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bus route liked!'),
                  duration: Duration(milliseconds: 100),
                ),
              );
            }
          },
        ),
        onTap: () => context.go('/details/${route.busNumber}'),
      ),
    );
  }
}
