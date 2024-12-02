import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/2_application/pages/LikedBusesScreen/bloc/liked_screen_event.dart';
import 'package:week_5/2_application/pages/LikedBusesScreen/bloc/liked_screen_state.dart';

class LikedBusesBloc extends Bloc<LikedBusesEvent, LikedBusesState> {
  final Box<BusRoute> busRoutesBox;

  LikedBusesBloc({required this.busRoutesBox}) : super(LikedBusesInitial()) {
    on<LoadLikedBuses>(_onLoadLikedBuses);
    on<DeleteLikedBus>(_onDeleteLikedBus);
  }

  Future<void> _onLoadLikedBuses(
    LoadLikedBuses event,
    Emitter<LikedBusesState> emit,
  ) async {
    try {
      emit(LikedBusesLoading());
      final likedBuses = busRoutesBox.values.toList();
      emit(LikedBusesLoaded(likedBuses));
    } catch (e) {
      emit(LikedBusesError(e.toString()));
    }
  }

  Future<void> _onDeleteLikedBus(
    DeleteLikedBus event,
    Emitter<LikedBusesState> emit,
  ) async {
    try {
      await busRoutesBox.deleteAt(event.index);
      final updatedLikedBuses = busRoutesBox.values.toList();
      emit(LikedBusesLoaded(updatedLikedBuses));
    } catch (e) {
      emit(LikedBusesError(e.toString()));
    }
  }
}