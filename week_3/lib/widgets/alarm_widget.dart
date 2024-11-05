import 'package:flutter/material.dart';

class AlarmWidget extends StatelessWidget {
  final String time;
  final bool isEnabled;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggle;

  const AlarmWidget({
    super.key,
    required this.time,
    required this.isEnabled,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Switch(
              value: isEnabled,
              onChanged: onToggle,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}