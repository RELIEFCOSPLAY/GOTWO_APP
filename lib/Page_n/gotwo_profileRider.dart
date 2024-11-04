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

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchData() async {
    final String url =
        'http://${Global.ip_80}/gotwo/status_Rider.php'; // URL ของ API
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=utf-8',
      });

      if (response.statusCode == 200) {
        setState(() {
          listData = json.decode(response.body); // แปลง JSON เป็น List
          isLoading = false;
        });
      } else {
        print("Failed to load data");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error be Fix: $e");
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
      fetchUserId(emails!); // เรียกใช้ API เพื่อตรวจสอบ user id
    }
  }

  Future<void> fetchUserId(String email) async {
    final String url =
        'http://${Global.ip_8080}/gotwo/getUserId_rider.php'; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'email': email, // ส่ง email เพื่อค้นหา user id
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            userId = data['user_id']; // เก็บ user id ที่ได้มา
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listData.isEmpty
              ? const Center(child: Text("No data available"))
              : Padding(
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                      Divider(height: 40, color: Colors.grey[300]),
                      const Text(
                        '140.00 Baht',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'wallet',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            final item = listData[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: Icon(Icons.account_circle,
                                    color: Colors.blue),
                                title: Text(item['rider_name'] ?? 'N/A',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'Phone: ${item['rider_tel'] ?? 'N/A'}'),
                                trailing:
                                    Icon(Icons.star, color: Colors.yellow),
                              ),
                              
                            );
                          },
                        ),
                      ),
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
}
