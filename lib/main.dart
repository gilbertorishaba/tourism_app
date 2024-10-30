import 'package:flutter/material.dart';
import 'package:tourism_app/my_drawer_header.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'destination_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Onboarding/welcome.dart';

void main() {
  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tourism App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const MainScreen(child: LoginScreen()),
        '/home': (context) => const MainScreen(child: HomeScreen()),
        '/destination': (context) =>
            const MainScreen(child: DestinationScreen()),
      },
    );
  }
}

// MainScreen Wrapper that contains the Navigation Bar and Drawer
class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({required this.child, super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Tourism App'),
      ),
      body: widget.child,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [const MyHeaderDrawer(), MyDrawerList()],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            onTabChange: _onTabChange,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favorites',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer List Items
  Widget MyDrawerList() {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favorites'),
          onTap: () {
            // Add logic for the Favorites screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.travel_explore),
          title: const Text('Sites'),
          onTap: () {
            // Add logic for the Favorites screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Destinations'),
          onTap: () {
            // Add logic for the Favorites screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            // Add logic for the Settings screen
          },
        ),
      ],
    );
  }
}
