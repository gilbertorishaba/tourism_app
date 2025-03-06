import 'package:flutter/material.dart';

/// Example placeholder screens for navigation.
/// In a real app, you'd place these in separate files and import them.
class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example "My Profile" screen with an edit icon at top-right
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement edit profile logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile tapped')),
              );
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img1.jpg'), // user image
            ),
            SizedBox(height: 16),
            Text('First Name: Susan', style: TextStyle(fontSize: 18)),
            Text('Last Name: Nasaka', style: TextStyle(fontSize: 18)),
            Text('Email: susannasaka@gmail.com',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _notificationsEnabled = true;
  bool _faceIDEnabled = false;

  // For the change password form
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: ListView(
        children: [
          // Notifications toggle
          SwitchListTile(
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() => _notificationsEnabled = val);
            },
          ),
          // Face ID toggle
          SwitchListTile(
            title: const Text('Face ID'),
            value: _faceIDEnabled,
            onChanged: (val) {
              setState(() => _faceIDEnabled = val);
            },
          ),
          // Change password
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => _showChangePasswordDialog(context),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Old Password',
                ),
              ),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement password change logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A placeholder privacy policy screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
Privacy Policy:

1. Data Collection:
   - LAITI collects personal data such as name, email, and usage statistics to enhance user experience.

2. Data Usage:
   - We use collected data to personalize content, improve services, and communicate updates.

3. Data Sharing:
   - We do not share personal data with third parties except when required by law or for service functionality.

4. User Rights:
   - You have the right to access, correct, or delete your personal data. Contact support@laiti.com for assistance.

5. Security:
   - We implement security measures to protect user data. However, no system is 100% secure.

For more details, visit our website or contact support@laiti.com.
            ''',
          ),
        ),
      ),
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  final String termsText = '''
1. Acceptance of Terms
By accessing or using our app ("LAITI"), you agree to be bound by these Terms and Conditions. If you disagree with any part of these terms, please do not use our service.

2. Description of Service
LAITI provides an online marketplace that connects travelers with hosts offering unique accommodations and experiences. Our platform facilitates bookings, payments, and communications between users.

3. User Eligibility
You must be at least 18 years old and legally capable of entering into a contract to use our services. By using LAITI, you represent and warrant that you meet these requirements.

4. Account Registration and Security
Registration: Users must provide accurate personal details during account registration.
Security: You are responsible for maintaining the confidentiality of your account login information. Any unauthorized use of your account should be reported immediately.

5. Booking and Payment
Booking Process: All bookings made via LAITI are subject to availability and confirmation by the host.
Payments: Payments are processed securely through our payment gateway. Full payment is generally required at the time of booking.
Cancellation and Refunds: Cancellation policies vary by listing. Please review the host's cancellation policy before confirming your booking. In cases where refunds are applicable, they will be processed according to the specified policy.

6. Host and Guest Responsibilities
For Guests: You agree to respect the property and abide by house rules set by the host. Any damages or violations may result in additional charges.
For Hosts: Hosts are responsible for accurately describing their listing, maintaining safety standards, and addressing any issues raised by guests during or after their stay.

7. Reviews and Ratings
Users may provide reviews and ratings based on their experience. These reviews are intended to help the community make informed decisions. LAITI reserves the right to remove content that violates our community guidelines.

8. Privacy and Data Protection
Your privacy is important to us. Please refer to our Privacy Policy for details on how we collect, use, and safeguard your personal information.

9. Intellectual Property
All content, trademarks, and data on LAITI are the property of their respective owners. Unauthorized use of any content may violate intellectual property laws.

10. Limitation of Liability
LAITI acts solely as an intermediary between guests and hosts. We are not responsible for the quality, safety, or legality of any listing or experience. In no event shall LAITI be liable for any indirect, incidental, or consequential damages arising from the use of our services.

11. Dispute Resolution
Any disputes arising from the use of our service shall be resolved through binding arbitration in accordance with the rules of the applicable jurisdiction. Users agree to waive their right to a trial by jury or to participate in a class action.

12. Modifications to Terms
LAITI reserves the right to update these Terms and Conditions at any time. Users will be notified of any material changes, and continued use of the service after such changes constitutes acceptance of the new terms.

13. Governing Law
These Terms and Conditions shall be governed by and construed in accordance with the laws of the jurisdiction in which LAITI operates.

14. Contact Us
For any questions regarding these Terms and Conditions, please contact our support team at support@laiti.com.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(termsText),
        ),
      ),
    );
  }
}

/// MAIN SETTINGS SCREEN
class SettingsScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  final ThemeMode currentThemeMode;

  const SettingsScreen({
    Key? key,
    required this.onThemeChanged,
    required this.currentThemeMode,
  }) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    // Initialize _isDarkMode based on the current theme mode passed from the parent
    _isDarkMode = widget.currentThemeMode == ThemeMode.dark;
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    widget.onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green[700],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          // Profile Section at the top
          _buildProfileSection(),

          // "My Profile" route
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text('My Profile',
                style: TextStyle(fontSize: 16, color: Colors.teal)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileDetailsScreen()),
              );
            },
          ),

          // "Security" route
          ListTile(
            leading: const Icon(Icons.security, color: Colors.teal),
            title: const Text('Security',
                style: TextStyle(fontSize: 16, color: Colors.teal)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecurityScreen()),
              );
            },
          ),

          // "Privacy Policy" route
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.teal),
            title: const Text('Privacy Policy',
                style: TextStyle(fontSize: 16, color: Colors.teal)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),

          // "Terms and Conditions" route
          ListTile(
            leading: const Icon(Icons.description, color: Colors.teal),
            title: const Text('Terms and Conditions',
                style: TextStyle(fontSize: 16, color: Colors.teal)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsScreen()),
              );
            },
          ),

          // "Dark Mode" toggle
          SwitchListTile(
            title: const Text('Dark Mode',
                style: TextStyle(fontSize: 16, color: Colors.teal)),
            value: _isDarkMode,
            activeColor: Colors.teal,
            onChanged: (value) => _toggleTheme(value),
          ),

          // "Logout" with confirmation
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.teal),
            title: const Text('Logout',
                style: TextStyle(fontSize: 16, color: Colors.teal)),
            onTap: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  /// Shows a modern confirmation dialog for logout
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement actual logout functionality here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logging out...')),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  /// Profile Section Widget at the top of Settings
  Widget _buildProfileSection() {
    return Container(
      color: Colors.green.shade50,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          // Circle Avatar
          CircleAvatar(
            radius: 40,
            backgroundImage: const AssetImage('assets/img1.jpg'),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // User info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Susan Nasaka',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'susan@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
