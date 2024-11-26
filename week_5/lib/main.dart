// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:week_5/2_application/pages/home_page.dart';
import 'package:week_5/2_application/services/themeservices.dart';
import 'package:week_5/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeService(),
    child: const Main(),
  ));
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(path: 'week_5/2_application/pages/home_page.dart',
  builder: (BuildContext context,GoRouterState state){
    return const HomePage();
  },)
]);

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, ThemeService, child) {
      return MaterialApp.router(
        routerConfig: _router,
        title: 'Bus Routes',
        themeMode: ThemeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
