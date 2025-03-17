// import 'package:flutter/material.dart';
// import 'package:tourism_app/services/auth_services.dart';

// class TokenDisplayScreen extends StatefulWidget {
//   const TokenDisplayScreen({Key? key}) : super(key: key);

//   @override
//   _TokenDisplayScreenState createState() => _TokenDisplayScreenState();
// }

// class _TokenDisplayScreenState extends State<TokenDisplayScreen> {
//   late Future<String> _tokenFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Retrieve the token when the widget initializes.
//     _tokenFuture = AuthService().getIdToken();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Token Debugger'),
//       ),
//       body: FutureBuilder<String>(
//         future: _tokenFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Text(
//                   snapshot.data!,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             );
//           }
//           return const Center(child: Text('No token available.'));
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Refresh the token when the button is pressed.
//           setState(() {
//             _tokenFuture = AuthService().getIdToken();
//           });
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
