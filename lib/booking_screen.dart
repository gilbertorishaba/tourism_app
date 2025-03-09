import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'my_drawer_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Terms and Conditions
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  final String termsText = '''
1. Acceptance of Terms
By accessing or using our Laiti, you agree to be bound by these Terms and Conditions. If you disagree with any part of these terms, please do not use our service.

2. Description of Service
LAITI provides an online marketplace that connects travelers with hosts offering unique accommodations and experiences. Our platform facilitates bookings, payments, and communications between users.

3. User Eligibility
You must be at least 18 years old and legally capable of entering into a contract to use our services. By using Laiti, you represent and warrant that you meet these requirements.

4. Account Registration and Security
Registration: Users must provide accurate personal details during account registration.
Security: You are responsible for maintaining the confidentiality of your account login information. Any unauthorized use of your account should be reported immediately.

5. Booking and Payment
Booking Process: All bookings made via Laiti are subject to availability and confirmation by the host.
Payments: Payments are processed securely through our payment gateway. Full payment is generally required at the time of booking.
Cancellation and Refunds: Cancellation policies vary by listing. Please review the host's cancellation policy before confirming your booking. In cases where refunds are applicable, they will be processed according to the specified policy.

6. Host and Guest Responsibilities
For Guests: You agree to respect the property and abide by house rules set by the host. Any damages or violations may result in additional charges.
For Hosts: Hosts are responsible for accurately describing their listing, maintaining safety standards, and addressing any issues raised by guests during or after their stay.

7. Reviews and Ratings
Users may provide reviews and ratings based on their experience. These reviews are intended to help the community make informed decisions. TourismX reserves the right to remove content that violates our community guidelines.

8. Privacy and Data Protection
Your privacy is important to us. Please refer to our Privacy Policy for details on how we collect, use, and safeguard your personal information.

9. Intellectual Property
All content, trademarks, and data on Laiti are the property of their respective owners. Unauthorized use of any content may violate intellectual property laws.

10. Limitation of Liability
LAITI acts solely as an intermediary between guests and hosts. We are not responsible for the quality, safety, or legality of any listing or experience. In no event shall TourismX be liable for any indirect, incidental, or consequential damages arising from the use of our services.

11. Dispute Resolution
Any disputes arising from the use of our service shall be resolved through binding arbitration in accordance with the rules of the applicable jurisdiction. Users agree to waive their right to a trial by jury or to participate in a class action.

12. Modifications to Terms
LAITI reserves the right to update these Terms and Conditions at any time. Users will be notified of any material changes, and continued use of the service after such changes constitutes acceptance of the new terms.

13. Governing Law
These Terms and Conditions shall be governed by and construed in accordance with the laws of the jurisdiction in which TourismX operates.

14. Contact Us
For any questions regarding these Terms and Conditions, please contact our support team at support@laiti.com.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Scrollable terms text
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  termsText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Agree and Disagree buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                  ),
                  child: const Text('Agree'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Disagree'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// BookingScreen with added location parameter
class BookingScreen extends StatefulWidget {
  final String destinationTitle;
  final String description;
  final String price;
  final String imageUrl;
  final String location;

  const BookingScreen({
    required this.destinationTitle,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.location,
    super.key,
  });

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
  TimeOfDay? _selectedTime;
  File? _selectedUserImage; //users image
  final ImagePicker _picker = ImagePicker();
  final PageController _pageController = PageController();

  // Pick user image from gallery
  Future<void> _pickUserImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedUserImage = File(pickedFile.path);
      });
    }
  }

  // Build circular avatar for user image with camera icon overlay
  Widget _buildUserImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: _selectedUserImage != null
              ? FileImage(_selectedUserImage!)
              : const AssetImage('assets/user_placeholder.png')
                  as ImageProvider,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 25,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: _pickUserImage,
            ),
          ),
        ),
      ],
    );
  }

  // Build sliding image widget for carousel (booking info images)
  Widget _buildSlidingImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: imageUrl.startsWith('assets/')
              ? AssetImage(imageUrl) as ImageProvider
              : NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Build date and time picker widget with InkWell for date
  Widget _buildDateTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Picker InkWell
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2025, 12, 31),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.green[600],
                    colorScheme: const ColorScheme.light(
                      primary: Color.fromARGB(255, 65, 127, 68),
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: Colors.white,
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green[600],
                      ),
                    ),
                    dialogTheme: DialogTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: child ?? const SizedBox(),
                );
              },
            );
            if (picked != null && picked != _selectedDate) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _selectedDate == null
                  ? 'Select Your Check-in Date'
                  : 'Check-in Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Time Picker InkWell
        InkWell(
          onTap: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                _selectedTime = pickedTime;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _selectedTime == null
                  ? 'Select Your Check-in Time'
                  : 'Check-in Time: ${_selectedTime!.format(context)}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Helper to build a text field widget
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Show Terms and Conditions and update acceptance
  Future<void> _showTermsAndConditions() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const TermsScreen()),
    );
    if (result == true) {
      setState(() {
        _termsAccepted = true;
      });
    } else {
      // If disagreed or canceled, pop the booking screen
      Navigator.pop(context);
    }
  }

  Future<void> submitBooking() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('bookings').add({
          'uid': user.uid, // Store the user ID along with the booking
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'checkInDate': _selectedDate?.toIso8601String(),
          'checkInTime':
              _selectedTime != null ? _selectedTime!.format(context) : null,
          'destination': widget.destinationTitle,
          'price': widget.price,
          'location': widget.location,
          'userImage':
              _selectedUserImage != null ? _selectedUserImage!.path : null,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        throw Exception('Booking submission failed: $e');
      }
    } else {
      // Handle case when user is not logged in
      print('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book With Us'),
        backgroundColor: Colors.green[700],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      drawer: const Drawer(child: MyDrawerHeader()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sliding Images Carousel (booking images)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.green.shade300, Colors.blue.shade300],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildSlidingImage(widget.imageUrl),
                    _buildSlidingImage('assets/img5.jpg'),
                    _buildSlidingImage('assets/img3.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Booking Details Card
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
                      const SizedBox(height: 10),
                      Text(
                        widget.price,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Optionally, display location if needed
                      Text(
                        widget.location,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              // User Image Picker (only user image)
              Center(child: _buildUserImage()),
              const SizedBox(height: 20),
              // Booking Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nameController, 'Full Name', Icons.person),
                    const SizedBox(height: 20),
                    _buildTextField(
                        _emailController, 'Email Address', Icons.email),
                    const SizedBox(height: 20),
                    _buildTextField(
                        _phoneController, 'Phone Number', Icons.phone),
                    const SizedBox(height: 20),
                    // Date & Time Picker
                    _buildDateTimePicker(),
                    const SizedBox(height: 20),
                    // Read Terms and Conditions button
                    ElevatedButton(
                      onPressed: _showTermsAndConditions,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Read Terms and Conditions'),
                    ),
                    const SizedBox(height: 20),
                    // Confirm Booking Button (requires terms acceptance)
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _termsAccepted) {
                          try {
                            await submitBooking();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Hello ${_nameController.text}, your application has been successfully submitted. Sit back, relax and wait for the confirmation!'),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        } else if (!_termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'You must accept the terms and conditions')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Confirm Booking'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
