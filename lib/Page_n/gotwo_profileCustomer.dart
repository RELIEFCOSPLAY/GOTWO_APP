import 'package:flutter/material.dart';

class GotwoProfileRider extends StatelessWidget {
  const GotwoProfileRider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Add your back button action here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Add edit profile functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1A1C43),
                  ),
                  child: const Icon(Icons.account_circle, size: 60, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Jenny Joy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        for (var i = 0; i < 5; i++) const Icon(Icons.star, color: Colors.yellow, size: 20),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Expiration date\n00/00/0000', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 40, color: Colors.grey[300]),
            const Text(
              '140.00 Baht',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'wallet',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildProfileInfo(Icons.phone, '0123456789'),
            _buildProfileInfo(Icons.calendar_today, '21/03/2024'),
            _buildProfileInfo(Icons.email, 'Email Customer'),
            _buildProfileInfo(Icons.admin_panel_settings, 'Contact Admin'),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Log out', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Add log out functionality here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1A1C43)),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
