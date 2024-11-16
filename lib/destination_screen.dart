import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'my_drawer_header.dart';

class Destination {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final String location;

  Destination({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.location,
  });
}

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final List<Destination> destinations = [
    Destination(
      title: 'Norwegian Islands',
      price: '\$1200',
      imageUrl: 'assets/img1.jpg',
      description: 'Beautiful Norwegian islands surrounded by the ocean.',
      location: 'Norway',
    ),
    Destination(
      title: 'Maldives',
      price: '\$1800',
      imageUrl: 'assets/img2.jpg',
      description:
          'Stunning views of the crystal clear waters of the Maldives.',
      location: 'Maldives',
    ),
    Destination(
      title: 'Bali Beaches',
      price: '\$1500',
      imageUrl: 'assets/img3.jpg',
      description: 'Relax at the serene beaches of Bali.',
      location: '',
    ),
    Destination(
      title: 'California Islands',
      price: '\$1800',
      imageUrl: 'assets/img4.jpg',
      description:
          'Relax at the serene beaches of California and be able to get an enjoyable moment .',
      location: 'California-USA',
    ),
    Destination(
      title: 'Las Vegas',
      imageUrl: 'assets/img5.jpg',
      description: 'Experience the vibrant nightlife of Las Vegas.',
      price: '\$3000',
      location: 'Las Vegas, USA',
    ),
    Destination(
      title: 'Santorini, Greece',
      imageUrl: 'assets/img6.jpg',
      description:
          'Experience stunning white-washed buildings with blue domes, crystal clear waters, and magnificent sunsets over the Aegean Sea.',
      price: '\$4000',
      location: 'Santorini, Greece',
    ),
    Destination(
      title: 'Bora Bora, French Polynesia',
      imageUrl: 'assets/img7.jpg',
      description:
          'Famous for its scenic beauty, lagoons, coral reefs, and luxurious overwater bungalows, surrounded by lush tropical landscape.',
      price: '\$1500',
      location: 'Bora Bora, French Polynesia',
    ),
    Destination(
      title: 'Faroe Islands, Denmark',
      imageUrl: 'assets/img14.jpg',
      description:
          'Experience the beautiful scenery of Denmark and discover the unique charm of the Faroe Islands.',
      price: '\$2800',
      location: 'Denmark',
    ),
    Destination(
      title: 'Petra, Jordan',
      imageUrl: 'assets/img16.jpg',
      description:
          'An archaeological marvel, Petra\'s ancient rock-cut architecture and vast desert landscape create an awe-inspiring setting.',
      price: '\$1500',
      location: 'Jordan, Middle East',
    ),
  ];

  List<Destination> filteredDestinations = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredDestinations = destinations;
  }

  // Function to filter destinations based on search query
  void _filterDestinations(String query) {
    List<Destination> filtered = destinations
        .where((destination) =>
            destination.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredDestinations = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Destinations'),
        centerTitle: true,
      ),
      drawer: const MyDrawerHeader(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Discover Amazing Places Around the World',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search location or destination...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                  _filterDestinations(
                      value); // Call filter function on search change
                },
              ),
            ),
            Expanded(
              child: filteredDestinations.isEmpty
                  ? const Center(
                      child: Text(
                        'No destinations found!',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : SingleChildScrollView(
                      child: CarouselSlider.builder(
                        itemCount: filteredDestinations.length,
                        itemBuilder: (context, index, realIndex) {
                          final destination = filteredDestinations[index];

                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(destination.title),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(destination.imageUrl),
                                      const SizedBox(height: 10),
                                      Text(destination.description),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      child: Image.asset(
                                        destination.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          destination.title,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Price: ${destination.price}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.green),
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Pass data when navigating to the booking screen
                                              Navigator.pushNamed(
                                                context,
                                                '/booking',
                                                arguments: {
                                                  'destinationTitle':
                                                      destination.title,
                                                  'price': destination.price,
                                                  'imageUrl':
                                                      destination.imageUrl,
                                                  'description':
                                                      destination.description,
                                                  'location':
                                                      destination.location,
                                                },
                                              );
                                            },
                                            child: const Text('Book Now'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.6,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: true,
                          initialPage: 0,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
