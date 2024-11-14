// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // For formatting dates

// class BookingScreen extends StatefulWidget {
//   final String destinationTitle;
//   final String price;

//   BookingScreen({required this.destinationTitle, required this.price});

//   @override
//   _BookingScreenState createState() => _BookingScreenState();
// }

// // class _BookingScreenState extends State<BookingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   bool _termsAccepted = false;

//   DateTime? _selectedDate;

//   final PageController _pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book your Stay'),
//         backgroundColor: Colors.green[700], // Nature-inspired green
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Sliding Images Carousel with gradient overlay
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [Colors.green.shade300, Colors.blue.shade300],
//                   ),
//                 ),
//                 child: PageView(
//                   controller: _pageController,
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     _buildSlidingImage('assets/image1.jpg'),
//                     _buildSlidingImage('assets/image2.jpg'),
//                     _buildSlidingImage('assets/image3.jpg'),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20), // Space between carousel and content

//               // Booking details section
//               Card(
//                 elevation: 10,
//                 margin: const EdgeInsets.only(bottom: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 color: Colors.brown.shade50, // Earthy brown background for card
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         widget.destinationTitle,
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green[900], // Deep green for text
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         widget.price,
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.green[600], // Lighter green for price
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Booking form section with rounded text fields
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     _buildTextField(_nameController, 'Full Name', Icons.person),
//                     SizedBox(height: 20),
//                     _buildTextField(
//                         _emailController, 'Email Address', Icons.email),
//                     SizedBox(height: 20),
//                     _buildTextField(
//                         _phoneController, 'Phone Number', Icons.phone),
//                     SizedBox(height: 20),

//                     // Date Picker
//                     Text(
//                       _selectedDate == null
//                           ? 'Select Your Check-in Date'
//                           : 'Check-in Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         final DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2020),
//                           lastDate: DateTime(2025),
//                         );
//                         if (picked != null && picked != _selectedDate)
//                           setState(() {
//                             _selectedDate = picked;
//                           });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Colors.green[600], // Green button color
//                       ),
//                       child: const Text('Pick a Date'),
//                     ),
//                     SizedBox(height: 20),

//                     // Terms and conditions checkbox
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: _termsAccepted,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _termsAccepted = value!;
//                             });
//                           },
//                         ),
//                         const Text(
//                           'I accept the terms and conditions',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),

//                     // Book Now Button
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate() &&
//                             _termsAccepted) {
//                           // Handle booking logic here
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Booking Confirmed!')),
//                           );
//                         } else if (!_termsAccepted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content: Text(
//                                     'You must accept the terms and conditions')),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green[700],
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         textStyle: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       child: Text('Confirm Booking'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build a text form field with an icon
//   Widget _buildTextField(
//       TextEditingController controller, String label, IconData icon) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your $label';
//         }
//         return null;
//       },
//     );
//   }

//   // Helper method to build sliding image
//   Widget _buildSlidingImage(String imagePath) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class BookingScreen extends StatefulWidget {
  final String destinationTitle;
  final String price;

  BookingScreen({required this.destinationTitle, required this.price});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _termsAccepted = false;

  DateTime? _selectedDate;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book your Stay'),
        backgroundColor: Colors.green[700], // Nature-inspired green
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background image with opacity
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sliding Images Carousel with gradient overlay
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green.shade300, Colors.blue.shade300],
                      ),
                    ),
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildSlidingImage('assets/banner.jpg'),
                        _buildSlidingImage('assets/img5.jpg'),
                        _buildSlidingImage('assets/img3.jpg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Booking details section
                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.brown.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.destinationTitle,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.price,
                            style: TextStyle(
                              fontSize: 22,
                              color:
                                  Colors.green[600], // Lighter green for price
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Booking form section with rounded text fields
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                            _nameController, 'Full Name', Icons.person),
                        SizedBox(height: 20),
                        _buildTextField(
                            _emailController, 'Email Address', Icons.email),
                        SizedBox(height: 20),
                        _buildTextField(
                            _phoneController, 'Phone Number', Icons.phone),
                        SizedBox(height: 20),

                        // Date Picker
                        Text(
                          _selectedDate == null
                              ? 'Select Your Check-in Date'
                              : 'Check-in Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025),
                            );
                            if (picked != null && picked != _selectedDate)
                              setState(() {
                                _selectedDate = picked;
                              });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green[600], // Green button color
                          ),
                          child: const Text('Pick a Date'),
                        ),
                        SizedBox(height: 20),

                        // Terms and conditions checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (bool? value) {
                                setState(() {
                                  _termsAccepted = value!;
                                });
                              },
                            ),
                            const Text(
                              'I accept the terms and conditions',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Book Now Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _termsAccepted) {
                              // Handle booking logic here
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booking Confirmed!')),
                              );
                            } else if (!_termsAccepted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'You must accept the terms and conditions')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          child: Text('Confirm Booking'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a text form field with an icon
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  // Helper method to build sliding image
  Widget _buildSlidingImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
