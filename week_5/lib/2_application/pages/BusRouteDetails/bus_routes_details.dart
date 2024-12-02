import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bloc/bus_route_details_bloc.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bloc/bus_route_details_state.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bloc/bus_route_details_event.dart'; // Add this
import 'package:week_5/2_application/widgets/route_details_content.dart';

class BusRouteDetailsScreen extends StatelessWidget {
  final String busNumber;

  const BusRouteDetailsScreen({required this.busNumber, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BusRouteDetailsBloc>().add(FetchRouteDetails(busNumber));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Details'),
        leading: IconButton(onPressed: () => context.go('/'), icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<BusRouteDetailsBloc, BusRouteDetailsState>(
        builder: (context, state) {
          if (state is BusRouteDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BusRouteDetailsLoaded) {
            return RouteDetailsContent(route: state.routeDetails);
          } else if (state is BusRouteDetailsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Select a route'));
        },
      ),
    );
  }
}
