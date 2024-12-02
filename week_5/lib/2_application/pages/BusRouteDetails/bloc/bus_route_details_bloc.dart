import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_5/1_domain/usecases/get_route_details.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bloc/bus_route_details_event.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bloc/bus_route_details_state.dart';

class BusRouteDetailsBloc extends Bloc<BusRouteDetailsEvent, BusRouteDetailsState> {
  final GetRouteDetails getRouteDetails;

  BusRouteDetailsBloc(this.getRouteDetails) : super(BusRouteDetailsInitial()) {
    on<FetchRouteDetails>((event, emit) async {
      try {
        emit(BusRouteDetailsLoading());
        final routeDetails = await getRouteDetails.execute(event.busNumber);
        emit(BusRouteDetailsLoaded(routeDetails));
      } catch (e) {
        emit(BusRouteDetailsError("Failed to fetch route details"));
      }
    });
  }
}