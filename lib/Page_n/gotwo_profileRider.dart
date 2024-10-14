import 'package:flutter/material.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_DashbordRider.dart';
import 'package:gotwo_app/gotwo_logout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GotwoProfileRider extends StatefulWidget {
  const GotwoProfileRider({super.key});

  @override
  _GotwoProfileRiderState createState() => _GotwoProfileRiderState();
}

class _GotwoProfileRiderState extends State<GotwoProfileRider> {
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // ดึงข้อมูลเมื่อเปิดหน้า
  }

  Future<void> _fetchProfileData() async {
    final response = await http.get(Uri.parse(
        'http://${Global.ip_80}/gotwo/status_Rider.php')); // แก้ URL ตามเซิร์ฟเวอร์ของคุณ

    if (response.statusCode == 200) {
      setState(() {
        profileData = json.decode(response.body); // เก็บข้อมูลที่ได้รับจาก PHP
      });
    } else {
      // แสดงข้อผิดพลาด
      print('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profile',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const GotwoDashbordrider()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // เพิ่มฟังก์ชันแก้ไขโปรไฟล์
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: profileData == null
            ? const Center(
                child:
                    CircularProgressIndicator()) // แสดงโหลดข้อมูลขณะดึงข้อมูล
            : Column(
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
                        child: const Icon(Icons.account_circle,
                            size: 60, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profileData!['rider_name'] ?? 'N/A',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              for (var i = 0; i < 5; i++)
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 40, color: Colors.grey[300]),
                  const Text(
                    '140.00 Baht', // สามารถเปลี่ยนข้อมูลนี้ได้หากเชื่อมต่อกับฐานข้อมูล
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'wallet',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileInfo(
                      Icons.phone, profileData!['raider_tel'] ?? 'N/A'),
                  _buildProfileInfo(Icons.email, 'Email Rider'),
                  _buildProfileInfo(
                      Icons.admin_panel_settings, 'Contact Admin'),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text('Log out',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogoutPage(),
                        ),
                      );
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
