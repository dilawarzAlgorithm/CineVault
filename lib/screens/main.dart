import 'package:cine_vault/screens/home.dart';
import 'package:cine_vault/screens/search.dart';
import 'package:cine_vault/screens/watchlist.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CineVault'), centerTitle: false),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            _currIndex = value;
          });
        },
        selectedIndex: _currIndex,
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
            icon: Icon(Icons.watch_later),
            label: 'Watchlist',
          ),
        ],
      ),
      body: <Widget>[
        HomeScreen(),
        SearchScreen(),
        WatchlistScreen(),
      ][_currIndex],
    );
  }
}
