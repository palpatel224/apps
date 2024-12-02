import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/bloc/bus_routes_bloc.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/bloc/bus_routes_event.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/bloc/bus_routes_state.dart';
import 'package:week_5/2_application/widgets/bus_route_widget.dart';


class AllBusRoutesScreen extends StatelessWidget {
  const AllBusRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BusRoutesBloc>().add(FetchAllBusRoutes(1, 100));

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Bus Routes"),
        actions: [
          IconButton(
            onPressed: () => context.go('/search'),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.go('/likedScreen')
          ),
        ],
      ),
      body: BlocBuilder<BusRoutesBloc, BusRoutesState>(
        builder: (context, state) {
          if (state is BusRoutesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BusRoutesLoaded) {
            return ListView.builder(
              itemCount: state.routes.length,
              itemBuilder: (context, index) => BusRouteCard(route: state.routes[index]),
            );
          } else if (state is BusRoutesError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}