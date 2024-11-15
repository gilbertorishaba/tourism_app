// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'app_localizations.dart';
// import 'login_screen.dart';
// import 'home_screen.dart';
// import 'destination_screen.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'Onboarding/welcome.dart';
// import 'booking_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'register_screen.dart';
// import 'forgot_password_screen.dart';

// void main() {
//   runApp(const TourismApp());
// }

// class TourismApp extends StatelessWidget {
//   const TourismApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'LAITI Tourism App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       localizationsDelegates: const [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [
//         Locale('en', 'US'),
//         Locale('es', 'ES'),
//         Locale('fr', 'FR'),
//         Locale('de', 'DE'),
//         Locale('it', 'IT'),
//         Locale('ru', 'RU'),
//         Locale('zh', 'CN'),
//         Locale('ja', 'JP'),
//         Locale('ar', 'AE'),
//         Locale('pt', 'PT'),
//       ],
//       initialRoute: '/onboarding',
//       routes: {
//         '/onboarding': (context) => (const OnboardingScreen()),
//         '/home': (context) => (const HomeScreen()),
//         '/login': (context) => const LoginScreen(),
//         '/register': (context) => const RegisterScreen(),
//         '/forgot_password': (context) => const ForgotPasswordScreen(),
//         '/destination': (context) =>
//             const MainScreen(child: DestinationScreen()),
//         '/booking': (context) {
//           final Map<String, String> args =
//               ModalRoute.of(context)!.settings.arguments as Map<String, String>;
//           return BookingScreen(
//             destinationTitle: args['destinationTitle']!,
//             price: args['price']!,
//           );
//         },
//       },
//     );
//   }
// }

// // MainScreen Wrapper that contains the Navigation Bar
// class MainScreen extends StatefulWidget {
//   final Widget child;

//   const MainScreen({required this.child, super.key});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   // Function to handle tab changes and navigate to corresponding screens
//   void _onTabChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()), // Home screen
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => const DestinationScreen()), // Destination screen
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => BookingScreen()), // Booking screen
//         );
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => const HomeScreen(
//                   showSettings: true)), // Home screen with settings widget
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         title: Text(
//           AppLocalizations.of(context)!.translate('LAITI'),
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: widget.child, // Display the current child screen
//       bottomNavigationBar: Container(
//         color: Colors.indigo,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//           child: GNav(
//             gap: 8,
//             backgroundColor: Colors.indigo,
//             color: Colors.white,
//             activeColor: Colors.white,
//             tabBackgroundColor: Colors.grey,
//             onTabChange: _onTabChange, // Handles the tab change navigation
//             padding: const EdgeInsets.all(16), // Padding for the GNav buttons
//             selectedIndex: _selectedIndex, // Keeps the selected tab highlighted
//             tabs: [
//               GButton(
//                 icon: CupertinoIcons.home,
//                 text: AppLocalizations.of(context)!.translate('/home'),
//               ),
//               GButton(
//                 icon: CupertinoIcons.heart,
//                 text: AppLocalizations.of(context)!.translate('/destinations'),
//               ),
//               GButton(
//                 icon: CupertinoIcons.car,
//                 text: AppLocalizations.of(context)!.translate('/booking'),
//               ),
//               GButton(
//                 icon: CupertinoIcons.settings,
//                 text: AppLocalizations.of(context)!.translate('/settings'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
        // '/home': (context) => (const HomeScreen()),
        '/home': (context) => MainScreen(child: const HomeScreen()),
        '/login': (context) => const LoginScreen(),
        '/settings': (context) => SettingsScreen(),
        '/register': (context) => const RegisterScreen(),
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

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({Key? key, required this.child}) : super(key: key);

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
            builder: (context) => SettingsScreen(),
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
            ),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
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
