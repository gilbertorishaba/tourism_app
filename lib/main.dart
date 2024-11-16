import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'destination_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Onboarding/welcome.dart';
import 'booking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'settings_screen.dart';

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
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
          Locale('fr', 'FR'),
          Locale('de', 'DE'),
          Locale('it', 'IT'),
          Locale('ru', 'RU'),
          Locale('zh', 'CN'),
          Locale('ja', 'JP'),
          Locale('ar', 'AE'),
          Locale('pt', 'PT'),
        ],
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (context) => (const OnboardingScreen()),
          '/home': (context) => const MainScreen(child: HomeScreen()),
          '/login': (context) => const LoginScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forgot_password': (context) => const ForgotPasswordScreen(),
          '/destination': (context) =>
              const MainScreen(child: DestinationScreen()),
          '/booking': (context) {
            // Fetching arguments passed when navigating to this route
            final Map<String, String>? args = ModalRoute.of(context)
                ?.settings
                .arguments as Map<String, String>?;

            final String destinationTitle =
                args?['destinationTitle'] ?? 'Unknown Destination';
            final String price = args?['price'] ?? 'Price not available';
            final String imageUrl = args?['imageUrl'] ?? 'default_image_url';
            final String description =
                args?['description'] ?? 'No description available';
            final String location =
                args?['location'] ?? 'Location not available';

            return BookingScreen(
              destinationTitle: destinationTitle,
              price: price,
              imageUrl: imageUrl,
              description: description,
              location: location,
            );
          },
        });
  }
}

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DestinationScreen(),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingScreen(
              destinationTitle: 'Beautiful Beach',
              price: '100 USD',
              imageUrl: 'imageUrl',
              location: '',
              description: '',
            ),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'LAITI',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: widget.child,
      bottomNavigationBar: Container(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.teal,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            onTabChange: _onTabChange,
            selectedIndex: _selectedIndex,
            tabs: const [
              GButton(
                icon: CupertinoIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.heart,
                text: 'Destinations',
              ),
              GButton(
                icon: CupertinoIcons.car,
                text: 'Booking',
              ),
              GButton(
                icon: CupertinoIcons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
