import 'package:flutter/material.dart';

void main() {
  runApp(GotwoProfile());
}

class GotwoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: Icon(Icons.arrow_back),
        actions: [Icon(Icons.edit)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenny Joy',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star, color: Colors.yellow);
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text('Expiration date: 00/00/0000'),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '140.00 Baht',
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text('wallet'),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('0123456789'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('21/03/2024'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Rider'),
              onTap: () {
                // Action when tapping Email Rider
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Contact Admin'),
              onTap: () {
                // Action when tapping Contact Admin
              },
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // Log out action
              },
              icon: Icon(Icons.power_settings_new, color: Colors.red),
              label: Text('Log out', style: TextStyle(color: Colors.red)),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
