import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_drawer_header.dart';
import 'services/firestore_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

  // Factory method to create Destination from Firestore document snapshot
  factory Destination.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Destination(
      title: data['title'] ?? '',
      price: data['price'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
    );
  }
}

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  List<Destination> destinations = [];
  List<Destination> filteredDestinations = [];
  String searchQuery = '';
  bool isLoading = true;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize Speech-to-Text
    _speech = stt.SpeechToText();

    fetchDestinationsFromFirestore();
  }

  // Fetch destinations from Firestore
  Future<void> fetchDestinationsFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('destinations').get();

    List<Destination> fetchedDestinations = querySnapshot.docs
        .map((doc) => Destination.fromFirestore(doc))
        .toList();

    setState(() {
      destinations = fetchedDestinations;
      filteredDestinations = fetchedDestinations;
      isLoading = false;
    });
  }

  // Function to start/stop voice listening
  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('Status: $val'),
        onError: (val) => print('Error: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            searchQuery = val.recognizedWords;
            _filterDestinations(searchQuery);
          }),
        );
      } else {
        print('Speech recognition not available.');
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Destinations'),
        centerTitle: true,
      ),
      drawer: const MyDrawerHeader(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Search bar with voice search integration
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search location or destination...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                          onPressed: _startListening,
                        ),
                      ),
                      onChanged: (value) {
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
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(destination.title),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(destination.imageUrl),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(15)),
                                            child: Image.network(
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    // Passing data when am moving to the booking screen
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/booking',
                                                      arguments: {
                                                        'destinationTitle':
                                                            destination.title,
                                                        'price':
                                                            destination.price,
                                                        'imageUrl': destination
                                                            .imageUrl,
                                                        'description':
                                                            destination
                                                                .description,
                                                        'location': destination
                                                            .location,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
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
