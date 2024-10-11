import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'destination_screen.dart';
import 'Onboarding/welcome.dart'; // Correctly pointing to the welcome screen

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
      initialRoute: '/welcome', // Start the app with the welcome screen
      routes: {
        '/welcome': (context) =>
            OnboardingScreen(), // Reference the correct class name in welcome.dart
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/destination': (context) => const DestinationScreen(),
      },
    );
  }
}
