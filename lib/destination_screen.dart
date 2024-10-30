import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Add carousel slider for smooth sliding effect
import 'package:google_nav_bar/google_nav_bar.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        'image': 'assetsimg3.jpg',
        'description': 'Relax at the serene beaches of Bali.',
        'price': '\$1500',
        'location': 'Bali, Indonesia'
      },
      {
        'title': 'California Islands',
        'image': 'assets/img4.jpg',
        'description':
            'Relax at the serene beaches of California and be able to get an enjoyable moment .',
        'price': '\$1800',
        'location': 'California, USA'
      },
      {
        'title': 'las Vegas',
        'image': 'assets/img4.jpg',
        'description': 'Come and taste the enchanting nature of California.',
        'price': '\$3000',
        'location': 'United States California'
      },
      {
        'title': 'Santorini, Greece',
        'image': 'assets/img5.jpg',
        'description':
            'Come and experience stunning white-washed buildings with blue domes, crystal clear waters and magnificent sunsets over the Aegen Sea.',
        'price': '\$4000',
        'location': 'Santorini, Greece'
      },
      {
        'title': 'Bora Bora, French Polynesia',
        'image': 'assets/img6.jpg',
        'description':
            'Famous for each scenic beauty lagoons, coral reefs and luxurious overwater bungalows, surrounded by lush tropical landscape.',
        'price': '\$1500',
        'location': 'Paris, France'
      },
      {
        'title': 'Machu Picchu, Peru',
        'image': 'assets/img7.jpg',
        'description': 'Relax at the serene beaches of Bali.',
        'price': '\$1500',
        'location': 'Peru, South America'
      },
      {
        'title': 'Plivitice Lakes, Croatia',
        'image': 'assets/img8.jpg',
        'description':
            'A UNESCO World Heritage site, this national park is filled with cascading waterfalls, crystal-clear lakes and vibrnt scenery',
        'price': '\$1500',
        'location': 'Croata, Europe'
      },
      {
        'title': 'Banff National Parker, Canada',
        'image': 'assets/img9.jpg',
        'description': 'Relax at the serene beaches of Bali.',
        'price': '\$1500',
        'location': 'Bali, Indonesia'
      },
      {
        'title': 'Maldives ',
        'image': 'assets/img10.jpg',
        'description':
            'With its pristine white-sand beaches, coral reefs and luxurious resorts',
        'price': '\$1200',
        'location': 'Maldives'
      },
      {
        'title': 'Kyotto, Japan',
        'image': 'assets/img11.jpg',
        'description':
            'Relax and chill with the famous historic temples, tranquil gardens and traditional tea houses, kyoto offers a glimpse into Japans rich culture heritage .',
        'price': '\$1500',
        'location': 'Kyotto Japan'
      },
      {
        'title': 'Tuscany Italy',
        'image': 'assets/img12.jpg',
        'description':
            ' Renowned for its rollling hills, vineyards and charming mediaval towns,Tuscany is a haven for wine lovers and art of ethusiasts',
        'price': '\$2300',
        'location': 'Tuscany Italy'
      },
      {
        'title': 'Iceland',
        'image': 'assets/img13.jpg',
        'description': 'Relax at the serene beaches of Iceland.',
        'price': '\$1500',
        'location': 'Iceland, United Kingdom'
      },
      {
        'title': 'Faroe Islands, Denmark',
        'image': 'assets/img14.jpg',
        'description':
            'Come experience the beautiful scenery of Denamrk and be able to distinguish from the wherever places u hard visited  .',
        'price': '\$2800',
        'location': 'Denmark'
      },
      {
        'title': 'Amalfi Coast, Italy',
        'image': 'assets/img15.jpg',
        'description':
            'A mediterranean jewel, this coastal region features colorful cliffdide villages, beautiful beaches and winding scenic roads .',
        'price': '\$2700',
        'location': 'Italy, Europe'
      },
      {
        'title': 'Petra, Jordan',
        'image': 'assets/img16.jpg',
        'description':
            'An acheological marvel, Petras ancient rock cut archticture and its vast desert landscape create an awe-nspiring setting .',
        'price': '\$1500',
        'location': 'South Arabia'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Destinations'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Discover Amazing Places Around the World',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CarouselSlider.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index, realIndex) {
                final destination = destinations[index];

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: Image.asset(
                          destination['image'],
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination['title'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(destination['description'],
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 10),
                            Text(
                              'Location: ${destination['location']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Price: ${destination['price']}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.green),
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
                );
              },
              options: CarouselOptions(
                height: 500,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                initialPage: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
