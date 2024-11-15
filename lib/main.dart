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
import 'settings_screen.dart';
import 'forgot_password_screen.dart';

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
        '/onboarding': (context) => (OnboardingScreen()),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
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
        Navigator.pushNamed(context, '/settings');
        break;
      case 3:
        Navigator.pushNamed(context, '/booking');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          AppLocalizations.of(context)!.translate('LAITI'),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: widget.child,
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
            onTabChange: _onTabChange, // Keeps the navigation behavior intact
            padding: const EdgeInsets.all(16), // Padding for the GNav buttons
            tabs: [
              GButton(
                icon: CupertinoIcons.home,
                text: AppLocalizations.of(context)!.translate('home'),
              ),
              GButton(
                icon: CupertinoIcons.heart,
                text: AppLocalizations.of(context)!.translate(' destinations'),
              ),
              GButton(
                icon: CupertinoIcons.car,
                text: AppLocalizations.of(context)!.translate('booking'),
              ),
              GButton(
                icon: CupertinoIcons.settings,
                text: AppLocalizations.of(context)!.translate('settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
