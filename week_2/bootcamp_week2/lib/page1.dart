import 'package:bootcamp_week2/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'destination_card.dart';

class MainPage extends StatelessWidget {

  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Places',style: themeData.textTheme.displayLarge,),
        actions: [
          Switch(
              value: Provider.of<ThemeService>(context).isDarkModeOn,
              onChanged: (_) {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
              })
        ],
      ),
      body: DestinationsView(destinations: sampleDestinations),
    );
  }
}

final sampleDestinations = [
  Destination(
    name: 'Borobudur Temple',
    description: 'Ancient Buddhist temple surrounded by lush gardens and mountains in Central Java.',
    imageUrl: 'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272',
  ),
  Destination(
    name: 'Mount Bromo',
    description: 'Active volcano in East Java known for its spectacular sunrise views.',
    imageUrl: 'https://images.unsplash.com/photo-1589308078059-be1415eab4c3',
  ),
  Destination(
    name: 'Raja Ampat',
    description: 'Paradise archipelago with pristine beaches and diverse marine life.',
    imageUrl: 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf',
  ),
  Destination(
    name: 'Komodo Island',
    description: 'Home to the famous Komodo dragons and beautiful pink beaches.',
    imageUrl: 'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86',
  ),
  Destination(
    name: 'Tana Toraja',
    description: 'Cultural region known for unique funeral rituals and traditional architecture.',
    imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
  ),
];