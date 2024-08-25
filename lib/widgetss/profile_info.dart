import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.phone, color: Color(0xFF10236E)),
          title: Text('0123456789'),
        ),
        ListTile(
          leading: Icon(Icons.calendar_today, color: Color(0xFF10236E)),
          title: Text('21/03/2024'),
        ),
        ListTile(
          leading: Icon(Icons.email, color: Color(0xFF10236E)),
          title: Text('Email Rider'),
          tileColor: Color(0xFFD8E8F6),
        ),
        ListTile(
          leading: Icon(Icons.person, color: Color(0xFF10236E)),
          title: Text('Contact Admin'),
        ),
      ],
    );
  }
}
