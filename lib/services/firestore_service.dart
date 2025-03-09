import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> addDestinationsToFirestore() async {
    final List<Map<String, dynamic>> destinations = [
      {
        'title': 'Norwegian Islands',
        'price': '\$1200',
        'imageUrl': 'assets/img1.jpg',
        'description': 'Beautiful Norwegian islands surrounded by the ocean.',
        'location': 'Norway',
      },
      {
        'title': 'Maldives',
        'price': '\$1800',
        'imageUrl': 'assets/img2.jpg',
        'description':
            'Stunning views of the crystal clear waters of the Maldives.',
        'location': 'Maldives',
      },
      {
        'title': 'Bali Beaches',
        'price': '\$1500',
        'imageUrl': 'assets/img3.jpg',
        'description': 'Relax at the serene beaches of Bali.',
        'location': 'Bali, Indonesia',
      },
      {
        'title': 'California Islands',
        'price': '\$1800',
        'imageUrl': 'assets/img4.jpg',
        'description':
            'Relax at the serene beaches of California and enjoy a great moment.',
        'location': 'California-USA',
      },
      {
        'title': 'Las Vegas',
        'price': '\$3000',
        'imageUrl': 'assets/img5.jpg',
        'description': 'Experience the vibrant nightlife of Las Vegas.',
        'location': 'Las Vegas, USA',
      },
      {
        'title': 'Santorini, Greece',
        'price': '\$4000',
        'imageUrl': 'assets/img6.jpg',
        'description':
            'Experience stunning white-washed buildings with blue domes, crystal clear waters, and magnificent sunsets over the Aegean Sea.',
        'location': 'Santorini, Greece',
      },
      {
        'title': 'Bora Bora, French Polynesia',
        'price': '\$1500',
        'imageUrl': 'assets/img7.jpg',
        'description':
            'Famous for its scenic beauty, lagoons, coral reefs, and luxurious overwater bungalows, surrounded by lush tropical landscape.',
        'location': 'Bora Bora, French Polynesia',
      },
      {
        'title': 'Bali Beaches',
        'price': '\$1500',
        'imageUrl': 'assets/img3.jpg',
        'description': 'Relax at the serene beaches of Bali.',
        'location': 'Bali, Indonesia',
      },
      {
        'title': 'Faroe Islands, Denmark',
        'price': '\$2800',
        'imageUrl': 'assets/img14.jpg',
        'description':
            'Experience the beautiful scenery of Denmark and discover the unique charm of the Faroe Islands.',
        'location': 'Denmark',
      },
      {
        'title': 'Petra, Jordan',
        'price': '\$1500',
        'imageUrl': 'assets/img16.jpg',
        'description':
            'Explore the ancient city of Petra with its remarkable rock-cut architecture.',
        'location': 'Jordan, Middle East',
      },
    ];

    CollectionReference destinationCollection =
        FirebaseFirestore.instance.collection('destinations');

    print("Starting to add destinations to Firestore...");

    for (var destination in destinations) {
      await destinationCollection.add(destination);
      print("Uploaded: ${destination['title']}");
    }

    print("All destinations added to Firestore!");
  }
}
