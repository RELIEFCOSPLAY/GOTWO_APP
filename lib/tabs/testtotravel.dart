import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotwo_app/Page_n/gotwo_totravel.dart';
import 'package:gotwo_app/global_ip.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TabTotravel extends StatefulWidget {
  const TabTotravel({super.key});

  @override
  State<TabTotravel> createState() => _TabTotravelState();
}

class _TabTotravelState extends State<TabTotravel> {
  List<dynamic> listData = [];
  List<dynamic> filteredList = [];

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchData() async {
    final String url =
        'http://${Global.ip_8080}/gotwo/status_Rider.php'; // URL ของ API
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json;charset=utf-8',
      });

      if (response.statusCode == 200) {
        setState(() {
          listData = json.decode(response.body); // แปลง JSON เป็น List
          filteredList =
              listData; // เริ่มต้นให้ filteredList มีค่าเท่ากับ listData ทั้งหมด
        });
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error be Fix: $e");
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
  void initState() {
    super.initState();
    fetchData();
    loadLoginInfo(); // ดึงข้อมูลเมื่อเริ่มแอป
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tab_Totravel(),
      ],
    );
  }

  Widget tab_Totravel() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 320,
        height: 500,
        child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            final item = listData[index];
            if (userId == item['rider_id'].toString() &&
                item['status'].toString() == 'totravel' &&
                (item['pay'] == '1' || item['pay'] == 1)) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GotwoTotravel(
                              item: item), // ส่งข้อมูลไปยัง GotwoTotravel
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xfffbf8ff)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Color(0xff1a1c43)),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the start
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xff1a1c43),
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      "From: ${item['pick_up'] ?? 'Unknown'}", // Check for null values
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff1a1c43),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Date: ${item['date'] ?? 'Unknown'}",
                                softWrap:
                                    false, // ป้องกันการตัดข้อความเป็นบรรทัดใหม่
                                overflow: TextOverflow
                                    .ellipsis, // ตัดข้อความหากยาวเกินไป
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff1a1c43),
                                ),
                              ),
                              Text(
                                // แปลงรูปแบบเวลาที่เป็น 'HH:MM:SS' ให้เป็นแค่ 'HH:MM'
                                "Time: ${item['time']?.substring(0, 5) ?? 'Unknown'}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff1a1c43),
                                ),
                              ),
                              Text(
                                item['pay'] == '1' ||
                                        item['pay'] == 1
                                    ? "Paid"
                                    : "Unpaid", // ถ้าเป็น 1 แสดง "Paid", ถ้าเป็น 0 แสดง "Unpaid"
                                style: TextStyle(
                                  fontSize: 12,
                                  color: item['pay'] == '1' ||
                                          item['pay'] == 1
                                      ? Colors.green // Green for "Paid"
                                      : Colors.red, // Red for "Unpaid"
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward,
                            color: Color(0xff1a1c43)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.tour,
                                    color: Color(0xff1a1c43),
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      "To: ${item['at_drop'] ?? 'Unknown'}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff1a1c43),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${item['price'] ?? 'N/A'} ",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff1a1c43),
                                    ),
                                  ),
                                  const Text(
                                    "THB",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff1a1c43),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink(); // ไม่แสดงอะไรถ้าไม่ตรงกัน
            }
          },
        ),
      ),
    );
  }
}
