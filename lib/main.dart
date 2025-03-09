import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourism_app/forgot_password_screen.dart';
import 'package:tourism_app/my_drawer_header.dart';
import 'package:tourism_app/settings_screen.dart';
import 'package:tourism_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_localizations.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'destination_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Onboarding/welcome.dart' as onboarding;
import 'booking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'register_screen.dart';
import 'services/tawk_chat_screen.dart';

// web fbase config
const firebaseConfig = {
  'apiKey': 'AIzaSyAWmIdIhsI1LW1zf5uLpVdjeuQG5dfZF0c',
  'authDomain': 'laiti-6e0f1.firebaseapp.com',
  'projectId': 'laiti-6e0f1',
  'storageBucket': 'laiti-6e0f1.firebasestorage.app',
  'messagingSenderId': '560767341852',
  'appId': '1:560767341852:web:0a4cd49ffcd6976a1a56d9',
  'measurementId': 'G-PLED0Q9VFZ',
};
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig['apiKey'] ?? '',
      authDomain: firebaseConfig['authDomain'] ?? '',
      projectId: firebaseConfig['projectId'] ?? '',
      storageBucket: firebaseConfig['storageBucket'] ?? '',
      messagingSenderId: firebaseConfig['messagingSenderId'] ?? '',
      appId: firebaseConfig['appId'] ?? '',
      measurementId: firebaseConfig['measurementId'] ?? '',
    ),
  );
  // Enable Firestore offline persistence
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const TourismApp());
}

class TourismApp extends StatefulWidget {
  const TourismApp({super.key});

  @override
  State<TourismApp> createState() => _TourismAppState();
}

class _TourismAppState extends State<TourismApp> {
  ThemeMode _themeMode = ThemeMode.light;

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const onboarding.OnboardingScreen(),
        '/home': (context) => const MainScreen(child: HomeScreen()),
        '/login': (context) => const LoginScreen(),
        '/settings': (context) => SettingsScreen(
              onThemeChanged: updateTheme,
              currentThemeMode: _themeMode,
            ),
        '/register': (context) => const RegisterScreen(),
        '/tawk_chat': (context) => const TawkChatScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/destination': (context) =>
            const MainScreen(child: DestinationScreen()),
        '/booking': (context) {
          final Map<String, String>? args = ModalRoute.of(context)
              ?.settings
              .arguments as Map<String, String>?;

          final String destinationTitle =
              args?['destinationTitle'] ?? 'Unknown Destination';
          final String price = args?['price'] ?? 'Price not available';
          final String imageUrl = args?['imageUrl'] ?? 'default_image_url';
          final String description =
              args?['description'] ?? 'No description available';
          final String location = args?['location'] ?? 'Location not available';

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
            builder: (context) => const BookingScreen(
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
      case 4:
        Navigator.pushReplacementNamed(context, '/tawk_chat');
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
