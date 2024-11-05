import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week3/services/theme_service.dart';
import 'package:week3/widgets/alarm_widget.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late Box alarmBox;

  @override
  void initState() {
    super.initState();
    alarmBox = Hive.box('alarm_box');
  }

  Future<void> _addAlarm() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final alarm = {
        'time': '${selectedTime.hour}:${selectedTime.minute}',
        'isEnabled': true,
      };
      await alarmBox.add(alarm);
    }
  }

  Future<void> _deleteAlarm(int index) async {
    await alarmBox.deleteAt(index);
  }

  Future<void> _toggleAlarm(int index, bool value) async {
    final alarm = Map<String, dynamic>.from(alarmBox.getAt(index));
    alarm['isEnabled'] = value;
    await alarmBox.putAt(index, alarm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              ThemeService.toggleTheme();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: alarmBox.listenable(),
        builder: (context, Box box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final alarm = Map<String, dynamic>.from(box.getAt(index));
              return AlarmWidget(
                time: alarm['time'],
                isEnabled: alarm['isEnabled'],
                onDelete: () => _deleteAlarm(index),
                onToggle: (value) => _toggleAlarm(index, value),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAlarm,
        child: const Icon(Icons.add),
      ),
    );
  }
}