
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_5/1_domain/usecases/bus_routes.dart';
import 'package:week_5/1_domain/usecases/get_all_bus_routes.dart';
import 'package:week_5/1_domain/usecases/search_bus_routes.dart';
import 'package:week_5/1_domain/usecases/get_route_details.dart';
import 'bus_routes_event.dart';
import 'bus_routes_state.dart';

class BusRoutesBloc extends Bloc<BusRoutesEvent, BusRoutesState> {
  final GetAllBusRoutes getAllBusRoutes;
  final SearchBusRoutes searchBusRoutes;
  final GetRouteDetails getRouteDetails;
  final BusRoutesUseCase busRoutesUseCase;

  BusRoutesBloc(
      {required this.getAllBusRoutes,
      required this.searchBusRoutes,
      required this.getRouteDetails,
      required this.busRoutesUseCase})
      : super(BusRoutesInitial()) {
    on<FetchAllBusRoutes>((event, emit) async {
      try {
        emit(BusRoutesLoading());
        final routes = await getAllBusRoutes.execute(event.page, event.size);
        emit(BusRoutesLoaded(routes));
      } catch (e) {
        emit(BusRoutesError("Failed to fetch routes."));
      }
    });

    on<SearchForBusRoutes>((event, emit) async {
      try {
        emit(BusRoutesLoading());
        final routes = await searchBusRoutes.execute(
          event.fromLocation,
          event.toLocation,
        );
        emit(BusRoutesLoaded(routes));
      } catch (e) {
        emit(BusRoutesError("No matching routes found."));
      }
    });

    on<FetchRouteDetails>((event, emit) async {
      try {
        emit(BusRoutesLoading());
        final routeDetails = await getRouteDetails.execute(event.busNumber);
        emit(RouteDetailsLoaded(routeDetails));
      } catch (e) {
        emit(BusRoutesError("Failed to fetch route details."));
      }
    });
    on<SearchBusByNumber>((event, emit) async {
      emit(BusRoutesLoading());
      try {
        final routes =
            await busRoutesUseCase.searchByBusNumber(event.busNumber);
        emit(BusRouteFound(routes));
      } catch (e) {
        emit(BusRoutesError("Bus route not found"));
      }
    });
  }
}
