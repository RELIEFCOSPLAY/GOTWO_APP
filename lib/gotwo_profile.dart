import 'package:flutter/material.dart';
import 'package:gotwo_app/widgetss/profile_avatar.dart';
import 'package:gotwo_app/widgetss/profile_info.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF10236E),
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back button action here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Add edit profile functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileAvatar(),
            SizedBox(height: 20),
            Text(
              '140.00 Baht',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'wallet',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            ProfileInfo(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/wallet'); // นำทางไปยัง WalletScreen
              },
              child: Text('Go to Wallet'),
              style: ElevatedButton.styleFrom(primary: Color(0xFF10236E)),
            ),
            TextButton.icon(
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text('Log out', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Add log out functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
