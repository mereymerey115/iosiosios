import 'package:flutter/material.dart';
import 'phone.dart';
import 'feed_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Phone> favorites = [];

  void toggleFavorite(Phone phone) {
    setState(() {
      if (favorites.contains(phone)) {
        favorites.remove(phone);
      } else {
        favorites.add(phone);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      FeedScreen(
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      FavoritesScreen(
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Store'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
