import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Section
            _buildProfileSection(),

            const SizedBox(height: 20),

            // General Settings
            _buildSettingsSection('General', [
              _buildSettingItem('Notifications', _notificationsEnabled,
                  (value) {
                setState(() {
                  _notificationsEnabled = value!;
                });
              }),
              _buildSettingItem('Dark Mode', _darkMode, (value) {
                setState(() {
                  _darkMode = value!;
                });
              }),
            ]),

            const SizedBox(height: 20),

            // Privacy Settings
            _buildSettingsSection('Privacy', [
              _buildSettingItem('Account Privacy', true, (value) {}),
              _buildSettingItem('Location Sharing', true, (value) {}),
            ]),

            const SizedBox(height: 20),

            // Social Media Integration
            _buildSettingsSection('Social Media', [
              _buildSettingItem('Connect Instagram', true, (value) {}),
              _buildSettingItem('Connect Facebook', true, (value) {}),
            ]),

            const SizedBox(height: 20),

            // Logout Section
            _buildLogoutSection(),
          ],
        ),
      ),
    );
  }

  // Profile section widget
  Widget _buildProfileSection() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/user_avatar.jpg'),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Bio: Traveler, Explorer, and Foodie',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // General Settings section widget
  Widget _buildSettingsSection(String title, List<Widget> settings) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 10),
            ...settings,
          ],
        ),
      ),
    );
  }

  // Setting item widget
  Widget _buildSettingItem(
      String title, bool currentValue, ValueChanged<bool?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.green[600],
          ),
        ),
        Switch(
          value: currentValue,
          onChanged: onChanged,
          activeColor: Colors.green[700],
        ),
      ],
    );
  }

  // Logout section widget
  Widget _buildLogoutSection() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logging out...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}