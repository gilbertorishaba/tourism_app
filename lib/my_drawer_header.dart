import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tourism_app/app_localizations.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text('Welcome, Gilbert Orishaba!',
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
              Navigator.pushReplacementNamed(context, '/Destination');
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
              }),
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
}
