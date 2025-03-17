// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<dynamic> fetchTourismData() async {
//   //create api
//   final response = await http.get(Uri.parse('http://api.laiti.com/tourism'));
//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Hello User👌, We are unable to load the data');
//   }
// }
// import 'package:http/http.dart' as http;
// import 'services/auth_services.dart'; // Make sure to import your AuthService

// Future<void> fetchBookings() async {
//   // Retrieve your token from AuthService
//   final authService = AuthService();
//   final token = await authService.getIdToken();

//   final response = await http.get(
//     Uri.parse('http://localhost:8080/bookings'),
//     headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     // Handle success
//     print('Bookings: ${response.body}');
//   } else {
//     // Handle error
//     print('Error: ${response.statusCode}');
//   }
// }
