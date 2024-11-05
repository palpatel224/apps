import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week3/pages/homepage.dart';
import 'package:week3/services/theme_service.dart';
import 'package:week3/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  await Hive.initFlutter();
  await Hive.openBox('alarm_box');
  await ThemeService.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('theme_box').listenable(),
      builder: (context, Box box, _) {
        final isDarkMode = ThemeService.isDarkMode();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Alarm App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const AlarmPage(),
        );
      },
    );
  }
}