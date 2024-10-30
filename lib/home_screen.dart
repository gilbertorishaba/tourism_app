import 'package:flutter/material.dart';
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
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Destinations'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          // Additional drawer items can go here
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
  final List<String> _languages = ['English', 'French', 'Spanish'];
  final List<String> _currencies = ['USD', 'EUR', 'JPY', 'GBP'];

  final TextEditingController _featureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              },
            ),
            Divider(),
            const Text('Currency',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedCurrency,
              items: _currencies.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue;
                });
              },
            ),
            Divider(),
            const Text('Request a Feature',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _featureController,
              decoration: const InputDecoration(
                labelText: 'Describe the feature you want',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final featureRequest = _featureController.text;
                print('Feature request submitted: $featureRequest');
                _featureController.clear();
              },
              child: const Text('Submit Feature Request'),
            ),
            Divider(),
            const Text('Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                print('Navigating to contact us');
              },
              child: Text('Contact Us'),
            ),
            Divider(),
            const Text('Privacy Policy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                print('Navigating to privacy policy');
              },
              child: const Text('View Privacy Policy'),
            ),
          ],
        ),
      ),
    );
  }
}

// Search Delegate for searching destinations
class DestinationSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> destinations = [
    {'title': 'Paris', 'image': 'assets/paris.jpg'},
    {'title': 'London', 'image': 'assets/london.jpg'},
    {'title': 'New York', 'image': 'assets/newyork.jpg'},
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = destinations
        .where((destination) =>
            destination['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results.map((destination) {
        return ListTile(
          title: Text(destination['title']!),
          leading: Image.asset(destination['image']!, width: 50, height: 50),
          onTap: () {
            Navigator.pushNamed(context, '/destination', arguments: {
              'title': destination['title'],
              'image': destination['image']
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = destinations
        .where((destination) =>
            destination['title']!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions.map((destination) {
        return ListTile(
          title: Text(destination['title']!),
          leading: Image.asset(destination['image']!, width: 50, height: 50),
          onTap: () {
            Navigator.pushNamed(context, '/destination', arguments: {
              'title': destination['title'],
              'image': destination['image']
            });
          },
        );
      }).toList(),
    );
  }
}
