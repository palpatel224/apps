// home_page_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_5/1_domain/repositories/bus_routes_repo.dart';
import 'package:week_5/2_application/pages/bloc/home_page_event.dart';
import 'package:week_5/2_application/pages/bloc/home_page_state.dart';

class BusRoutesBloc extends Bloc<BusRoutesEvent, BusRoutesState> {
  final BusRoutesRepository repository;
  int currentPage = 1;
  static const int itemsPerPage = 10;
  bool hasReachedMax = false;

  BusRoutesBloc({required this.repository}) : super(BusRoutesState()) {
    on<LoadBusRoutes>(_onLoadBusRoutes);
    on<LoadMoreBusRoutes>(_onLoadMoreBusRoutes);
  }

  Future<void> _onLoadBusRoutes(
    LoadBusRoutes event,
    Emitter<BusRoutesState> emit,
  ) async {
    emit(state.copyWith(status: BusRouteStatus.loading));
    try {
      currentPage = 1;
      hasReachedMax = false;
      final routes = await repository.getBusRoutes(currentPage, itemsPerPage);
      emit(state.copyWith(
        status: BusRouteStatus.success,
        routes: routes,
        hasReachedMax: routes.isEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BusRouteStatus.failure,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreBusRoutes(
    LoadMoreBusRoutes event,
    Emitter<BusRoutesState> emit,
  ) async {
    if (hasReachedMax) return;
    
    try {
      currentPage++;
      final moreRoutes = await repository.getBusRoutes(currentPage, itemsPerPage);
      
      if (moreRoutes.isEmpty) {
        hasReachedMax = true;
        return;
      }

      emit(state.copyWith(
        status: BusRouteStatus.success,
        routes: [...state.routes, ...moreRoutes],
        hasReachedMax: moreRoutes.isEmpty,
      ));
    } catch (e) {
      currentPage--;
      emit(state.copyWith(
        status: BusRouteStatus.failure,
        error: e.toString(),
      ));
    }
  }
}