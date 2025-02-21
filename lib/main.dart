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
// import 'settings_screen.dart';

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
//       // Use your original light theme with primarySwatch blue
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // Integrated dark theme settings
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Colors.black,
//         scaffoldBackgroundColor: Colors.black,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.grey[900],
//           iconTheme: const IconThemeData(color: Colors.white),
//         ),
//         // Additional dark theme settings can be defined here
//       ),
//       // Toggle theme based on system settings (or force dark by using ThemeMode.dark)
//       themeMode: ThemeMode.system,
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
//         '/onboarding': (context) => const OnboardingScreen(),
//         '/home': (context) => const MainScreen(child: HomeScreen()),
//         '/login': (context) => const LoginScreen(),
//         '/settings': (context) => const SettingsScreen(),
//         '/register': (context) => const RegisterScreen(),
//         '/forgot_password': (context) => const ForgotPasswordScreen(),
//         '/destination': (context) =>
//             const MainScreen(child: DestinationScreen()),
//         '/booking': (context) {
//           // Fetching arguments passed when navigating to this route
//           final Map<String, String>? args = ModalRoute.of(context)
//               ?.settings
//               .arguments as Map<String, String>?;
//           final String destinationTitle =
//               args?['destinationTitle'] ?? 'Unknown Destination';
//           final String price = args?['price'] ?? 'Price not available';
//           final String imageUrl = args?['imageUrl'] ?? 'default_image_url';
//           final String description =
//               args?['description'] ?? 'No description available';
//           final String location = args?['location'] ?? 'Location not available';

//           return BookingScreen(
//             destinationTitle: destinationTitle,
//             price: price,
//             imageUrl: imageUrl,
//             description: description,
//             location: location,
//           );
//         },
//       },
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   final Widget child;
//   const MainScreen({super.key, required this.child});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   void _onTabChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const SettingsScreen(),
//           ),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const DestinationScreen(),
//           ),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookingScreen(
//               destinationTitle: 'Beautiful Beach',
//               price: '100 USD',
//               imageUrl: 'imageUrl',
//               location: '',
//               description: '',
//             ),
//           ),
//         );
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const SettingsScreen(),
//           ),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: const Text(
//           'LAITI',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: widget.child,
//       bottomNavigationBar: Container(
//         color: Colors.teal,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//           child: GNav(
//             gap: 8,
//             backgroundColor: Colors.teal,
//             color: Colors.white,
//             activeColor: Colors.white,
//             tabBackgroundColor: Colors.grey,
//             onTabChange: _onTabChange,
//             selectedIndex: _selectedIndex,
//             tabs: const [
//               GButton(
//                 icon: CupertinoIcons.home,
//                 text: 'Home',
//               ),
//               GButton(
//                 icon: CupertinoIcons.heart,
//                 text: 'Destinations',
//               ),
//               GButton(
//                 icon: CupertinoIcons.car,
//                 text: 'Booking',
//               ),
//               GButton(
//                 icon: CupertinoIcons.settings,
//                 text: 'Settings',
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
import 'package:tourism_app/my_drawer_header.dart';
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

class TourismApp extends StatefulWidget {
  const TourismApp({super.key});

  @override
  State<TourismApp> createState() => _TourismAppState();
}

class _TourismAppState extends State<TourismApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default to light theme

  // Callback to update the app's theme
  void updateTheme(ThemeMode newThemeMode) {
    setState(() {
      _themeMode = newThemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAITI Tourism App',
      // Light theme remains as your original settings
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Dark theme settings (will only be applied if the user triggers it)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      // Instead of following the system, use our _themeMode variable
      themeMode: _themeMode,
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
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => MainScreen(child: const HomeScreen()),
        '/login': (context) => const LoginScreen(),
        // Updated SettingsScreen route: passing required parameters.
        '/settings': (context) => SettingsScreen(
              onThemeChanged: updateTheme,
              currentThemeMode: _themeMode,
            ),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/destination': (context) =>
            MainScreen(child: const DestinationScreen()),
        '/booking': (context) {
          // Fetching arguments passed when navigating to this route
          final Map<String, String>? args = ModalRoute.of(context)
              ?.settings
              .arguments as Map<String, String>?;

          // Extracting the arguments
          final String destinationTitle =
              args?['destinationTitle'] ?? 'Unknown Destination';
          final String price = args?['price'] ?? 'Price not available';
          final String imageUrl = args?['imageUrl'] ?? 'default_image_url';
          final String description =
              args?['description'] ?? 'No description available';
          final String location = args?['location'] ?? 'Location not available';

          // Returning the BookingScreen widget with all required arguments
          return BookingScreen(
            destinationTitle: destinationTitle,
            price: price,
            imageUrl: imageUrl,
            description: description,
            location: location,
          );
        },
      },
    );
  }
}

// MainScreen Wrapper that contains the Navigation Bar and Drawer remains unchanged
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
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/destination');
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
        Navigator.pushReplacementNamed(context, '/settings');
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
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [const MyDrawerHeader(), MyDrawerList()],
          ),
        ),
      ),
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
            // Add logic for Favorites screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.travel_explore),
          title: const Text('Sites'),
          onTap: () {
            // Add logic for Sites screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Destinations'),
          onTap: () {
            // Add logic for Destinations screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }
}
