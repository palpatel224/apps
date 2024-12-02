import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:week_5/0_data/datasources/remote_datasource.dart';
import 'package:week_5/0_data/repositories/busroute_repo_impl.dart';
import 'package:week_5/1_domain/entities/bus_routes_entites.dart';
import 'package:week_5/1_domain/usecases/bus_routes.dart';
import 'package:week_5/1_domain/usecases/get_all_bus_routes.dart';
import 'package:week_5/1_domain/usecases/get_route_details.dart';
import 'package:week_5/1_domain/usecases/search_bus_routes.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/all_bus_routes.dart';
import 'package:week_5/2_application/pages/AllBusRoutesScreen/bloc/bus_routes_bloc.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bloc/bus_route_details_bloc.dart';
import 'package:week_5/2_application/pages/BusRouteDetails/bus_routes_details.dart';
import 'package:week_5/2_application/pages/LikedBusesScreen/liked_buses_screen.dart';
import 'package:week_5/2_application/pages/SearchBusRoutes/search_bus_routes.dart';
import 'package:week_5/2_application/services/themeservices.dart';
import 'package:week_5/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(BusRouteAdapter());
  }
  await Hive.openBox<BusRoute>('busRoutes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = BusRouteRemoteDataSource(http.Client());
    final repository = BusRouteRepositoryImpl(remoteDataSource);
    final getRouteDetails = GetRouteDetails(repository);
    final getAllBusRoutes = GetAllBusRoutes(repository);
    final searchBusRoutes = SearchBusRoutes(repository);
    final busRoutesUseCase = BusRoutesUseCase(repository);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AllBusRoutesScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchBusRoutesScreen(),
        ),
        GoRoute(
          path: '/details/:busNumber',
          builder: (context, state) => BusRouteDetailsScreen(
            busNumber: state.pathParameters['busNumber'] ?? '',
          ),
        ),
        GoRoute(
          path: '/likedScreen',
          builder: (context, state) => const LikedBusesScreen(),
        )
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        BlocProvider<BusRoutesBloc>(
          create: (context) => BusRoutesBloc(
            getAllBusRoutes: getAllBusRoutes,
            searchBusRoutes: searchBusRoutes,
            getRouteDetails: getRouteDetails,
            busRoutesUseCase: busRoutesUseCase,
          ),
        ),
        BlocProvider<BusRouteDetailsBloc>(
          create: (context) => BusRouteDetailsBloc(getRouteDetails),
        ),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp.router(
            routerConfig: router,
            title: 'Mangalore Buses',
            debugShowCheckedModeBanner: false,
            themeMode:
                themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        },
      ),
    );
  }
}
