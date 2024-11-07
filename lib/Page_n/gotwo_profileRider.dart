import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  List<dynamic> listData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String url = 'http://${Global.ip_80}/gotwo/status_Rider.php';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=utf-8',
      });

      if (response.statusCode == 200) {
        setState(() {
          listData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Failed to load data");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  final storage = const FlutterSecureStorage();
  String? emails;
  String? userId;
  Future<void> loadLoginInfo() async {
    String? savedEmail = await storage.read(key: 'email');
    setState(() {
      emails = savedEmail;
    });
    if (emails != null) {
      fetchUserId(emails!);
    }
  }

  Future<void> fetchUserId(String email) async {
    final String url = 'http://${Global.ip_8080}/gotwo/getUserId_rider.php';
    try {
      final response = await http.post(Uri.parse(url), body: {
        'email': email,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            userId = data['user_id'];
          });
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print("Failed to fetch user id");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Color(0xFF1A1C43),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1C43)),
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
            icon: const Icon(Icons.edit, color: Color(0xFF1A1C43)),
            onPressed: () {
              // เพิ่มฟังก์ชันแก้ไขโปรไฟล์
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listData.isEmpty
              ? const Center(child: Text("No data available"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ส่วนของโปรไฟล์ด้านบน
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
                              Text(
                                listData.isNotEmpty
                                    ? listData[0]['rider_name'] ?? 'N/A'
                                    : 'N/A',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A1C43)),
                              ),
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
                      const SizedBox(height: 20),
                      // ส่วนของ Wallet
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E7FF),
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              listData.isNotEmpty &&
                                      listData[0]['price'] != null
                                  ? '${listData[0]['price']} Baht'
                                  : '0.00 Baht',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'wallet',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ส่วนเบอร์โทร
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Color(0xFF1A1C43)),
                          const SizedBox(width: 10),
                          Text(
                            listData.isNotEmpty
                                ? listData[0]['rider_tel'] ?? 'N/A'
                                : 'N/A',
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF1A1C43)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // ปุ่ม Email Rider
                      TextButton.icon(
                        icon: const Icon(Icons.email, color: Color(0xFF1A1C43)),
                        label: const Text('Email Rider',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1A1C43),
                            )),
                        onPressed: () {
                          // เพิ่มการทำงานส่งอีเมลถึง Rider
                        },
                      ),
                      const SizedBox(height: 10),
                      // ปุ่ม Contact Admin
                      TextButton.icon(
                        icon:
                            const Icon(Icons.person, color: Color(0xFF1A1C43)),
                        label: const Text('Contact Admin',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1A1C43),
                            )),
                        onPressed: () {
                          // เพิ่มการทำงานติดต่อแอดมิน
                        },
                      ),
                      const Spacer(),
                      // ปุ่ม Log out
                      TextButton.icon(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        label: const Text(
                          'Log out',
                          style: TextStyle(color: Colors.red),
                        ),
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
}
