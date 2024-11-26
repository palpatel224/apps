import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_4/services/theme_services.dart';
import 'package:week_4/widgets/events_widget.dart'; // Import the calendar widget we created earlier

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  // Calendar Tab
                  const CalendarWidget(),

                  // Schedule Tab
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text('Schedule View Coming Soon'),
                    ),
                  ),

                  // Settings Tab
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          trailing: Switch(
                            value: true,
                            onChanged: (bool value) {
                              // Add notification settings logic
                            },
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.color_lens),
                          title: const Text('Theme'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Add theme settings navigation
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.sync),
                          title: const Text('Sync Settings'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Add sync settings navigation
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // You can add direct event creation logic here if needed
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}