import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAITI Travel App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _textPosition = 0; //initial  if the text
  bool _startAnimation = false; //start the animation

  @override
  void initState() {
    super.initState();
    //start the timer to trigger animation after 5 seconds
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _startAnimation = true; //enables me to start animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Destinations'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // open Drawer
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DestinationSearchDelegate(),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              _buildAnimatedText(
                  context), // Corrected placement for animated text
              const SizedBox(height: 20),
              _buildCentralHub(context), // Central hub for navigation
              const SizedBox(height: 20),
              _buildPopularCategories(context), // Quick access categories
              const SizedBox(height: 20),
              const Text(
                'Top Tourist Destinations',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              _buildDestinationCard(
                  context, 'Paris', 'City of Light', 'assets/paris.jpg'),
              _buildDestinationCard(
                  context, 'London', 'Glamorous City', 'assets/london.jpg'),
              _buildDestinationCard(
                  context, 'New York', 'The Big Apple', 'assets/newyork.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  //handle animated text
  Widget _buildAnimatedText(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: MediaQuery.of(context).size.width, end: -200),
      duration: const Duration(seconds: 5),
      curve: Curves.linear,
      builder: (context, value, child) {
        return Container(
          transform: Matrix4.translationValues(value, 0, 0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.teal),
              SizedBox(width: 8),
              Text(
                'Welcome to LAITI',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.star, color: Colors.teal),
            ],
          ),
        );
      },
      onEnd: () {
        setState(() {
          _startAnimation = false;
        });
      },
    );
  }

  Widget _buildCentralHub(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Explore the World',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIconButton(context, CupertinoIcons.airplane, 'Flights',
                () => Navigator.pushNamed(context, '/flights')),
            _buildIconButton(context, CupertinoIcons.bed_double_fill, 'Hotels',
                () => Navigator.pushNamed(context, '/hotels')),
            _buildIconButton(context, CupertinoIcons.location_fill, 'Explore',
                () => Navigator.pushNamed(context, '/explore')),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30),
          onPressed: onPressed,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildPopularCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryButton(
                context, 'Beaches', CupertinoIcons.sun_max_fill),
            _buildCategoryButton(
                context, 'Mountains', CupertinoIcons.cloud_drizzle_fill),
            _buildCategoryButton(
                context, 'Cities', CupertinoIcons.building_2_fill),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/category',
            arguments: {'category': label});
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 30,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(
      BuildContext context, String title, String subtitle, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/destination',
            arguments: {'title': title, 'image': imagePath});
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(imagePath,
                  fit: BoxFit.cover, height: 180, width: double.infinity),
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/img4.jpg'),
                  radius: 30,
                ),
                SizedBox(height: 10),
                Text('Welcome, Traveler!',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/favorites');
            },
          ),
          ListTile(
            leading: const Icon(Icons.travel_explore),
            title: const Text('Sites'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/sites');
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedLanguage = 'English';
  String? _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Language'),
            subtitle: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              },
              items: <String>['English', 'French', 'Spanish']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Currency'),
            subtitle: DropdownButton<String>(
              value: _selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue;
                });
              },
              items: <String>['USD', 'EUR', 'GBP']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: 10, //dummy suggestion list
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Destination $index'),
          onTap: () {
            query = 'Destination $index';
            showResults(context);
          },
        );
      },
    );
  }
}
