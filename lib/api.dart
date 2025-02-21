// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<dynamic> fetchTourismData() async {
//   final response = await http.get(Uri.parse('https://api.example.com/tourism'));
//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to load tourism data');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchTourismData() async {
  final response = await http.get(Uri.parse('http://api.example.com/tourism'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load tourism data');
  }
}
