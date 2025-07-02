import 'package:flutter/material.dart';
import 'package:my_awesome_namer/screens/settings_screen.dart';

import '../screens/favourite_screen.dart';
import '../screens/home_screen.dart';

/// [LayoutDispatcher] is the class that handles the navigation between the different screens.
/// In a switch statement we check the current index and return the corresponding screen.
/// The navigation UI is implemented using the [NavigationRail] widget.
///
class LayoutDispatcher extends StatefulWidget {
  const LayoutDispatcher({super.key});

  @override
  State<LayoutDispatcher> createState() => _LayoutDispatcherState();
}

class _LayoutDispatcherState extends State<LayoutDispatcher> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page = FavouriteScreen();
        break;
      case 2:
        page = SettingsScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorite'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
          VerticalDivider(width: 1, thickness: 1.5),
          Expanded(
            child: Padding(padding: const EdgeInsets.all(8.0), child: page),
          ),
        ],
      ),
    );
  }
}
