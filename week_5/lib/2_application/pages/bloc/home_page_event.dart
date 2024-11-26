abstract class BusRoutesEvent {
  const BusRoutesEvent();
}

class FetchBusRoutes extends BusRoutesEvent {}

class LoadMoreBusRoutes extends BusRoutesEvent {}

class LoadBusRoutes extends BusRoutesEvent {}
