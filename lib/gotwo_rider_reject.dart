import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_DashbordRider.dart';
import 'package:gotwo_app/gotwo_logout.dart';
import 'package:http/http.dart' as http;

class GotwoRiderReject extends StatefulWidget {
  const GotwoRiderReject({super.key});

  @override
  State<GotwoRiderReject> createState() => _GotwoRiderRejectState();
}

class _GotwoRiderRejectState extends State<GotwoRiderReject> {
  List<dynamic> listData = [];
  final storage = const FlutterSecureStorage();
  String? emails;
  String? userId;
  String? sumPriceRider;
  String? avgReview;
  int? rating;

  @override
  void initState() {
    super.initState();
    loadLoginInfo();
    fetchData();
  }

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
    final String url =
        "http://${Global.ip_8080}/gotwo/getUserId_rider.php"; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'email': email, // ส่ง email เพื่อค้นหา user id
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            userId = data['user_id']; // เก็บ user id ที่ได้มา
            fetchSumPrice(userId!);
            fetchAVGRating(userId!);
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

  Future<void> fetchData() async {
    final String url = "http://${Global.ip_8080}/gotwo/profile_dataRider.php";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          listData = json.decode(response.body);
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchSumPrice(String userid) async {
    final String url =
        "http://${Global.ip_8080}/gotwo/sum_Rider_value.php"; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'userid': userid, // ส่ง user id เพื่อค้นหา sum
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            // ตรวจสอบประเภทของ sum_price และแปลงเป็น String หากจำเป็น
            sumPriceRider = data['sum_price'].toString();
          });
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print("Failed to fetch user id");
      }
    } catch (e) {
      print("F Error: $e");
    }
  }

  Future<void> fetchAVGRating(String userid) async {
    final String url =
        "http://${Global.ip_8080}/gotwo/avg_RiderRating.php"; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'userid': userid, // ส่ง user id เพื่อค้นหา avg
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            avgReview = data['avg_review'].toString();
            // พยายามแปลงเป็น int
            try {
              double avgReviewDouble = double.parse(avgReview!);
              rating = avgReviewDouble.toInt();
            } catch (e) {
              print('Error: Unable to parse avg_review to int.');
              rating = 0; // กำหนดค่าเริ่มต้น
            }
          });
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print("Failed to fetch avg review");
      }
    } catch (e) {
      print("F Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: listData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await fetchData(); // ดึงข้อมูลใหม่จากเซิร์ฟเวอร์
                fetchSumPrice(userId!);
                fetchAVGRating(userId!);
              },
              color: const Color(0xff1a1c43), // สีของวงกลม Refresh
              backgroundColor: Colors.white, // สีพื้นหลังของ RefreshIndicator
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  final item = listData[index];
                  // String uid = item['regis_rider_id'];
                  String imgShow =
                      "http://${Global.ip_8080}/${item['img_profile'] ?? ''}";

                  // แสดงเฉพาะข้อมูลของผู้ใช้ที่ล็อกอินอยู่
                  if (userId.toString() == item['regis_rider_id'].toString()) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Card
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1C43),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: item['status_rider'] == '1'
                                      ? _backButton()
                                      : const SizedBox(), // ใช้ SizedBox() แทน null เพื่อให้มี Widget ที่ไม่แสดงผล
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      minRadius: 25,
                                      maxRadius: 40,
                                      backgroundColor: Colors.white,
                                      child: item['img_profile'] != null
                                          ? ClipOval(
                                              child: Image.network(
                                                imgShow,
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                              ),
                                            )
                                          : const Icon(Icons.person),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      item['name'] ?? 'Unknown',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 5),
                                        Text(
                                          item['status_rider'] == '0'
                                              ? "Pending"
                                              : item['status_rider'] == '1'
                                                  ? "Normal"
                                                  : item['status_rider'] == '2'
                                                      ? "Suspend"
                                                      : item['status_rider'] ==
                                                              '3'
                                                          ? "Reject"
                                                          : "Unknown", // เพิ่มข้อความเผื่อกรณีสถานะไม่ตรง
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: item['status_rider'] == '0'
                                                ? Colors
                                                    .blue // สีสำหรับ Pending
                                                : item['status_rider'] == '1'
                                                    ? Colors
                                                        .green // สีสำหรับ Normal
                                                    : item['status_rider'] ==
                                                            '2'
                                                        ? Colors
                                                            .red // สีสำหรับ Suspend
                                                        : item['status_rider'] ==
                                                                '3'
                                                            ? Colors
                                                                .orange // สีสำหรับ Reject
                                                            : Colors
                                                                .grey, // สีสำหรับสถานะที่ไม่รู้จัก
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Profile Details Section

                        // Logout Button
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogoutPage()),
                            );
                          },
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text(
                            'Exit',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("back");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const GotwoDashbordrider(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileDetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
