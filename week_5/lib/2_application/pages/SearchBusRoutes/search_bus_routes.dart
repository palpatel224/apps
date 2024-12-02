import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/bloc/bus_routes_bloc.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/bloc/bus_routes_event.dart';
import 'package:week_5/2_application/widgets/bus_route_widget.dart';
import '../AllBusRoutesScreen/bloc/bus_routes_state.dart';
import 'package:week_5/2_application/widgets/route_details_content.dart';

class NormalizedTextController extends TextEditingController {
  @override
  set text(String newText) {
    String normalized = newText.trim().toLowerCase();
    normalized = normalized.replaceAll(RegExp(r'\s+'), ' ');
    super.text = normalized;
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    value = value.copyWith(
      text: text.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' '),
      selection: selection,
    );
    return super.buildTextSpan(
        context: context, style: style, withComposing: withComposing);
  }
}

class SearchBusRoutesScreen extends StatefulWidget {
  const SearchBusRoutesScreen({super.key});

  @override
  State<SearchBusRoutesScreen> createState() => _SearchBusRoutesScreenState();
}

class _SearchBusRoutesScreenState extends State<SearchBusRoutesScreen> {
  final TextEditingController fromController = NormalizedTextController();
  final TextEditingController toController = NormalizedTextController();
  final TextEditingController busNumberController = TextEditingController();

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    busNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<BusRoutesBloc>().add(FetchAllBusRoutes(1, 100));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Routes"),
          leading: IconButton(onPressed: () => context.go('/'), icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: busNumberController,
                decoration: const InputDecoration(
                  labelText: 'Bus Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: fromController,
                decoration: const InputDecoration(
                  labelText: "From Location",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: toController,
                decoration: const InputDecoration(
                  labelText: "To Location",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (busNumberController.text.isNotEmpty) {
                    context.read<BusRoutesBloc>().add(
                        SearchBusByNumber(busNumber: busNumberController.text));
                  } else if (fromController.text.isNotEmpty &&
                      toController.text.isNotEmpty) {
                    context.read<BusRoutesBloc>().add(SearchForBusRoutes(
                        fromController.text, toController.text));
                  }
                },
                child: const Text('Search Routes'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<BusRoutesBloc, BusRoutesState>(
                  builder: (context, state) {
                    if (state is BusRoutesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BusRoutesLoaded) {
                      return ListView.builder(
                        itemCount: state.routes.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            title: const Text('Route Details'),
                                          ),
                                          body: RouteDetailsContent(
                                              route: state.routes[index]),
                                        )));
                          },
                          child: BusRouteCard(route: state.routes[index])
                        ),
                      );
                    } else if (state is BusRouteFound) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: const Text('Route Details'),
                                ),
                                body: RouteDetailsContent(route: state.route),
                              ),
                            ),
                          );
                        },
                        child: BusRouteCard(route: state.route,)
                      );
                    } else if (state is BusRoutesError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('Search for bus routes'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
