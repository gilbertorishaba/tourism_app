import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.jpg',
                      height: 80,
                    ),
                    const SizedBox(height: 20),
                    // Welcome text
                    const Text(
                      'Welcome to Register',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Dear traveller ❤️ create an account to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Form container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                labelStyle: TextStyle(color: Colors.teal),
                                border: OutlineInputBorder(),
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.blue),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              onChanged: (value) => email = value,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                labelStyle: TextStyle(color: Colors.teal),
                                border: OutlineInputBorder(),
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.blue),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onChanged: (value) => password = value,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                hintText: 'Confirm your password',
                                labelStyle: TextStyle(color: Colors.teal),
                                border: OutlineInputBorder(),
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.blue),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value != password) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Successfully registered'),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.indigo,
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Login Here link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account? '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Login Here',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
