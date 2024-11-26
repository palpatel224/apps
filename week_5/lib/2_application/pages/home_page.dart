// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_5/0_data/repositories/busroute_repo_impl.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';
import 'package:week_5/2_application/pages/bloc/home_page_bloc.dart';
import 'package:week_5/2_application/pages/bloc/home_page_event.dart';
import 'package:week_5/2_application/pages/bloc/home_page_state.dart';
import 'package:week_5/2_application/pages/route_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusRoutesBloc(
        repository: BusRoutesRepository(BusRoutesApiService()),
      )..add(LoadBusRoutes()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Routes'),
      ),
      body: BlocBuilder<BusRoutesBloc, BusRoutesState>(
        builder: (context, state) {
          if (state.status == BusRouteStatus.initial) {
            return const SizedBox();
          }

          if (state.status == BusRouteStatus.loading && state.routes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BusRouteStatus.failure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<BusRoutesBloc>().add(LoadBusRoutes());
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  context.read<BusRoutesBloc>().add(LoadMoreBusRoutes());
                }
                return true;
              },
              child: ListView.builder(
                itemCount: state.routes.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.routes.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final route = state.routes[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Route ${route.busNumber}'),
                      subtitle: Text(
                        'From: ${route.fromLocation}\nTo: ${route.toLocation}',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RouteDetailsPage(route: route),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}