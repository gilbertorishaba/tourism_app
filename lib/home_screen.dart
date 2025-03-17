import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tourism_app/app_localizations.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/gestures.dart';

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
  double _textPosition = 0;
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _startAnimation = true;
      });
    });
  }

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
              const SizedBox(height: 20),
              _buildCentralHub(context),
              const SizedBox(height: 20),
              _buildPopularCategories(context),
              const SizedBox(height: 20),
              const HoverTapVideoPlayer(),
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

  // handle animated text
  Widget _buildCenteredText(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.teal,
              size: 30,
            ),
            const SizedBox(width: 8),
            Text(
              'Welcome to LAITI',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.star,
              color: Colors.teal,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
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

Widget _buildIconButton(
    BuildContext context, IconData icon, String label, VoidCallback onPressed) {
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
          _buildCategoryButton(context, 'Beaches', CupertinoIcons.sun_max_fill),
          _buildCategoryButton(
              context, 'Mountains', CupertinoIcons.cloud_drizzle_fill),
          _buildCategoryButton(
              context, 'Cities', CupertinoIcons.building_2_fill),
        ],
      ),
    ],
  );
}

Widget _buildCategoryButton(BuildContext context, String label, IconData icon) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/category', arguments: {'category': label});
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
          leading: const Icon(CupertinoIcons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.square_favorites),
          title: const Text('Destinations'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/destination');
          },
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.car),
          title: Text(AppLocalizations.of(context)!.translate('booking')),
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
          leading: const Icon(CupertinoIcons.settings),
          title: const Text('Setting'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/settings');
          },
        ),
      ],
    ),
  );
}

class DestinationSearchDelegate extends SearchDelegate {
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
    return ListView(
      children: [
        ListTile(title: Text('Result for "$query"')),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('Suggested: $query')),
      ],
    );
  }
}

class HoverTapVideoPlayer extends StatefulWidget {
  const HoverTapVideoPlayer({super.key});

  @override
  _HoverTapVideoPlayerState createState() => _HoverTapVideoPlayerState();
}

class _HoverTapVideoPlayerState extends State<HoverTapVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverEnter(PointerEnterEvent event) {
    _controller.play();
  }

  void _onHoverExit(PointerExitEvent event) {
    _controller.pause();
  }

  void _onTap() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onHoverEnter,
      onExit: _onHoverExit,
      child: GestureDetector(
        onTap: _onTap,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
