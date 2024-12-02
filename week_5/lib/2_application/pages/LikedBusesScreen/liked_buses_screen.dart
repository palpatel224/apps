import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/2_application/pages/LikedBusesScreen/bloc/liked_screen_bloc.dart';
import 'package:week_5/2_application/pages/LikedBusesScreen/bloc/liked_screen_event.dart';
import 'package:week_5/2_application/pages/LikedBusesScreen/bloc/liked_screen_state.dart';
import 'package:week_5/2_application/widgets/bus_route_widget.dart';

class LikedBusesScreen extends StatelessWidget {
  const LikedBusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedBusesBloc(
        busRoutesBox: Hive.box<BusRoute>('busRoutes'),
      )..add(LoadLikedBuses()),
      child: const LikedBusesView(),
    );
  }
}

class LikedBusesView extends StatelessWidget {
  const LikedBusesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Buses'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: BlocBuilder<LikedBusesBloc, LikedBusesState>(
        builder: (context, state) {
          if (state is LikedBusesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LikedBusesError) {
            return Center(child: Text(state.message));
          }

          if (state is LikedBusesLoaded) {
            if (state.likedBuses.isEmpty) {
              return const Center(child: Text('No liked buses'));
            }

            return ListView.builder(
              itemCount: state.likedBuses.length,
              itemBuilder: (context, index) {
                final busRoute = state.likedBuses[index];
                return Dismissible(
                  key: ValueKey(busRoute.busNumber),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<LikedBusesBloc>().add(
                          DeleteLikedBus(index: index, busRoute: busRoute),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bus route removed!'),
                        duration: Duration(milliseconds: 100),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: BusRouteCard(route: busRoute),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
