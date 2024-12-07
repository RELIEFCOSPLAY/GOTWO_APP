import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotwo_app/Page_n/gotwo_profileRider.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_PostPage.dart';
import 'package:gotwo_app/gotwo_SatusRider.dart';
import 'package:gotwo_app/gotwo_logout.dart';
import 'package:http/http.dart' as http;

class GotwoDashbordrider extends StatefulWidget {
  const GotwoDashbordrider({super.key});

  @override
  State<GotwoDashbordrider> createState() => _GotwoDashbordriderState();
}

class _GotwoDashbordriderState extends State<GotwoDashbordrider> {
  final storage = const FlutterSecureStorage();

  String? userId;
  String? imgUrl;
  String? emails;
  String? statusRider;
  String? sumPostRider;
  String? sumConRider;
  String? sumReqRider;

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
            imgUrl = data['imgUrl'];
            statusRider = data['statusRider'];
            fetchSumPost(userId!);
            fetchSumCon(userId!);
            fetchSumRequest(userId!);
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

  Future<void> fetchSumPost(String userid) async {
    final String url =
        "http://${Global.ip_8080}/gotwo/sum_Rider_Post.php"; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'userid': userid, // ส่ง user id เพื่อค้นหา sum
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            // ตรวจสอบประเภทของ sum_price และแปลงเป็น String หากจำเป็น
            sumPostRider = data['sum_post'].toString();
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

  Future<void> fetchSumCon(String userid) async {
    final String url =
        "http://${Global.ip_8080}/gotwo/sum_Rider_Con.php"; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'userid': userid, // ส่ง user id เพื่อค้นหา sum
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            // ตรวจสอบประเภทของ sum_price และแปลงเป็น String หากจำเป็น
            sumConRider = data['sum_con'].toString();
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

  Future<void> fetchSumRequest(String userid) async {
    final String url =
        "http://${Global.ip_8080}/gotwo/sum_Rider_Request.php"; // URL API
    try {
      final response = await http.post(Uri.parse(url), body: {
        'userid': userid, // ส่ง user id เพื่อค้นหา sum
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            // ตรวจสอบประเภทของ sum_price และแปลงเป็น String หากจำเป็น
            sumReqRider = data['sum_req'].toString();
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

  @override
  void initState() {
    super.initState();
    loadLoginInfo(); // ดึงข้อมูลเมื่อหน้าเริ่มต้น
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff1a1c43),
            Color(0xff1a1c43),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: statusRider != '1'
            ? _suspendPage() // หน้าแสดงเมื่อ statusRider == 1
            : statusRider == '1'
                ? _page()
                : const Center(
                    child: CircularProgressIndicator()), // แสดงสถานะโหลด
      ),
    );
  }

  Widget _suspendPage() {
    return Container(
      color: Colors.white, // พื้นหลังสีขาว
      child: Column(
        children: [
          if (statusRider == '1')
            const Center(child: CircularProgressIndicator())
          else ...[
            const Spacer(), // เพิ่ม Spacer เพื่อดัน Loader ให้อยู่กลาง
            const Center(
                child: CircularProgressIndicator()), // แสดงสถานะโหลดตรงกลาง
            const Spacer(), // Spacer จะดันปุ่มลงไปล่างสุด
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 16.0), // เพิ่มระยะห่างด้านล่าง
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LogoutPage()),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Exit',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white, // สีพื้นหลังปุ่มเป็นสีขาว
                  padding: const EdgeInsets.all(12.0), // เพิ่มระยะ Padding
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_inforAvaterBox()],
            ),
            _dashbordBox(),
          ],
        ),
      ),
    );
  }

  Widget _inforAvaterBox() {
    String imgShow = 'http://${Global.ip_8080}/$imgUrl';
    return GestureDetector(
      onTap: () {
        debugPrint("CircleAvatar");
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CircleAvatar(
              minRadius: 25,
              maxRadius: 40,
              backgroundColor: Colors.white,
              child: imgUrl != null
                  ? ClipOval(
                      // ใช้ ClipOval เพื่อครอบภาพให้เป็นวงกลม
                      child: Image.network(
                        imgShow,
                        fit: BoxFit.cover, // ปรับให้รูปภาพเติมเต็มพื้นที่
                        width: 80, // กำหนดขนาดความกว้าง
                        height: 80, // กำหนดขนาดความสูง
                      ),
                    )
                  : const Icon(Icons.person),
            ),
            const SizedBox(height: 10),
            Text(
              '$emails',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              " Enjoy the journey ",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashbordBox() {
    return Container(
      width: double.infinity,
      height: 440,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, left: 40),
                child: Text(
                  "Dashboard",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff1a1c43),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint("1");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GotwoSatusrider(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xffF55168),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${sumReqRider}",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Request",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint("2");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GotwoSatusrider(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xff17C8B1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${sumConRider}",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  debugPrint("3");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GotwoPostPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00D6D5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: const Size(300, 80),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${sumPostRider}',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text(
                      "Post    ",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff1a1c43),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  debugPrint("Dashboard");
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.home,
                      size: 50.0,
                    ),
                    Text("Dashboard")
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff1a1c43),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  debugPrint("Status");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GotwoSatusrider(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.grading,
                      size: 50.0,
                    ),
                    Text("Status")
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff1a1c43),
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  debugPrint("Profile");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GotwoProfileRider(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 50.0,
                    ),
                    Text("Profile")
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
