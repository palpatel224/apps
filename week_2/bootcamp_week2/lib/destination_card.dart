import 'package:flutter/material.dart';
class Destination {
  final String name;
  final String description;
  final String imageUrl;

  Destination({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            destination.imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.name,
                  style: themeData.textTheme.bodyLarge
                ),
                const SizedBox(height: 4),
                Text(
                  destination.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class DestinationsView extends StatelessWidget {
  final List<Destination> destinations;

  const DestinationsView({
    super.key,
    required this.destinations,
  });
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        return DestinationCard(destination: destinations[index]);
      },
    );
  }
}