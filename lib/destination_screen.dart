import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'my_drawer_header.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final List<Map<String, dynamic>> destinations = [
    {
      'title': 'Norwegian Islands',
      'image': 'assets/img1.jpg',
      'description': 'Beautiful Norwegian islands surrounded by the ocean.',
      'price': '\$1200',
      'location': 'Norway'
    },
    {
      'title': 'Maldives',
      'image': 'assets/img2.jpg',
      'description':
          'Stunning views of the crystal clear waters of the Maldives.',
      'price': '\$1800',
      'location': 'Maldives'
    },
    {
      'title': 'Bali Beaches',
      'image': 'assets/img3.jpg',
      'description': 'Relax at the serene beaches of Bali.',
      'price': '\$1500',
      'location': 'Bali, Indonesia'
    },
    {
      'title': 'California Islands',
      'image': 'assets/img4.jpg',
      'description':
          'Relax at the serene beaches of California and enjoy an unforgettable moment.',
      'price': '\$1800',
      'location': 'California, USA'
    },
    {
      'title': 'Las Vegas',
      'image': 'assets/img5.jpg',
      'description': 'Experience the vibrant nightlife of Las Vegas.',
      'price': '\$3000',
      'location': 'Las Vegas, USA'
    },
    {
      'title': 'Santorini, Greece',
      'image': 'assets/img6.jpg',
      'description':
          'Experience stunning white-washed buildings with blue domes, crystal clear waters, and magnificent sunsets over the Aegean Sea.',
      'price': '\$4000',
      'location': 'Santorini, Greece'
    },
    {
      'title': 'Bora Bora, French Polynesia',
      'image': 'assets/img7.jpg',
      'description':
          'Famous for its scenic beauty, lagoons, coral reefs, and luxurious overwater bungalows, surrounded by lush tropical landscape.',
      'price': '\$1500',
      'location': 'Bora Bora, French Polynesia'
    },
    {
      'title': 'Machu Picchu, Peru',
      'image': 'assets/img8.jpg',
      'description': 'Discover the ancient ruins of Machu Picchu.',
      'price': '\$1500',
      'location': 'Peru, South America'
    },
    {
      'title': 'Plitvice Lakes, Croatia',
      'image': 'assets/img9.jpg',
      'description':
          'A UNESCO World Heritage site, this national park is filled with cascading waterfalls, crystal-clear lakes, and vibrant scenery.',
      'price': '\$1500',
      'location': 'Croatia, Europe'
    },
    {
      'title': 'Banff National Park, Canada',
      'image': 'assets/img10.jpg',
      'description': 'Explore the stunning landscapes of Banff.',
      'price': '\$1500',
      'location': 'Banff, Canada'
    },
    {
      'title': 'Kyoto, Japan',
      'image': 'assets/img11.jpg',
      'description':
          'Relax with famous historic temples, tranquil gardens, and traditional tea houses; Kyoto offers a glimpse into Japan\'s rich cultural heritage.',
      'price': '\$1500',
      'location': 'Kyoto, Japan'
    },
    {
      'title': 'Tuscany, Italy',
      'image': 'assets/img12.jpg',
      'description':
          'Renowned for its rolling hills, vineyards, and charming medieval towns, Tuscany is a haven for wine lovers and art enthusiasts.',
      'price': '\$2300',
      'location': 'Tuscany, Italy'
    },
    {
      'title': 'Iceland',
      'image': 'assets/img13.jpg',
      'description': 'Explore the breathtaking landscapes of Iceland.',
      'price': '\$1500',
      'location': 'Iceland, Europe'
    },
    {
      'title': 'Faroe Islands, Denmark',
      'image': 'assets/img14.jpg',
      'description':
          'Experience the beautiful scenery of Denmark and discover the unique charm of the Faroe Islands.',
      'price': '\$2800',
      'location': 'Denmark'
    },
    {
      'title': 'Amalfi Coast, Italy',
      'image': 'assets/img15.jpg',
      'description':
          'A Mediterranean jewel, this coastal region features colorful cliffside villages, beautiful beaches, and winding scenic roads.',
      'price': '\$2700',
      'location': 'Amalfi Coast, Italy'
    },
    {
      'title': 'Petra, Jordan',
      'image': 'assets/img16.jpg',
      'description':
          'An archaeological marvel, Petra\'s ancient rock-cut architecture and vast desert landscape create an awe-inspiring setting.',
      'price': '\$1500',
      'location': 'Jordan, Middle East'
    },
  ];

  List<Map<String, dynamic>> filteredDestinations = [];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    //Initial display all of destination
    filteredDestinations = destinations;
  }

  //  Function to filter destinations-search query
  void _filterDestinations(String query) {
    List<Map<String, dynamic>> filtered = destinations
        .where((destination) =>
            destination['title'].toLowerCase().contains(query.toLowerCase()) ||
            destination['location'].toLowerCase().contains(query.toLowerCase()))
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
        // banner
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
                  // Update search query and filter destinations
                  setState(() {
                    searchQuery = value;
                  });
                  _filterDestinations(value);
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
                              // Show dialog with more details
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(destination['title']),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        destination['image'],
                                        fit: BoxFit.cover,

                                        // changed
                                        height: 100,
                                        width: double.infinity,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(destination['description']),
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
                                        destination['image'],
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
                                          destination['title'],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(destination['description'],
                                            style:
                                                const TextStyle(fontSize: 16)),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Location: ${destination['location']}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Price: ${destination['price']}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.green),
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Implement booking logic
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
                          height: MediaQuery.of(context).size.height *
                              0.6, // Adjust carousel height
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
