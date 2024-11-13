import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/profile.jpg'), // Ensure the image path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            'Might class', // You can change this text to be dynamic
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'info@BBC.com', // Replace with dynamic email if needed
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }
}
