import 'package:flutter/material.dart';
import 'my_drawer_header.dart'; // Correct import for MyHeaderDrawer
import 'login_screen.dart';
import 'home_screen.dart';
import 'destination_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Onboarding/welcome.dart';
import 'booking_screen.dart';

void main() {
  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAITI Tourism App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/onboarding', // Set onboarding as the initial route
      routes: {
        '/onboarding': (context) =>
            const OnboardingScreen(), // Define onboarding screen route
        '/login': (context) => const MainScreen(
            child: LoginScreen()), // Login screen after onboarding
        '/home': (context) => const MainScreen(child: HomeScreen()),
        '/destination': (context) =>
            const MainScreen(child: DestinationScreen()),
        '/booking': (context) {
          final Map<String, String> args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return BookingScreen(
            destinationTitle: args['destinationTitle']!,
            price: args['price']!,
          );
        },
      },
    );
  }
}

// MainScreen Wrapper that contains the Navigation Bar
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

    // Navigate to different screens based on index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/destination');
        break;
      case 2:
        // You can add a search screen here if you have one
        break;
      case 3:
        // Navigate to settings screen when implemented
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('LAITI Tourism App'),
      ),
      body: widget.child,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const MyHeaderDrawer(), // Updated to use MyHeaderDrawer
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Destinations'),
              onTap: () {
                Navigator.pushNamed(context, '/destination');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Booking'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/booking',
                  arguments: {
                    'destinationTitle': 'Maldives',
                    'price': '500 USD',
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings screen
              },
            ),
          ],
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
            tabBackgroundColor: Colors.grey,
            onTabChange: _onTabChange,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Destinations',
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
}
