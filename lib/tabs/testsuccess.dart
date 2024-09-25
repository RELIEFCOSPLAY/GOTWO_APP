import 'package:flutter/material.dart';
import 'package:gotwo_app/Page_n/gotwo_success_paid.dart';
import 'package:gotwo_app/Page_n/gotwo_success_unpaid.dart'; // นำเข้า GotwoSuccessUnpaid
import 'package:gotwo_app/global_ip.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TabSuccess extends StatefulWidget {
  @override
  State<TabSuccess> createState() => _TabSuccessState();
}

class _TabSuccessState extends State<TabSuccess> {
  List<dynamic> listData = [];
  List<dynamic> filteredList = [];

  String ipUser = "192.168.160.1:80";
  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchData() async {
    final String url = "http://${Global.ip_8080}/gotwo/status.php"; // URL ของ API
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

  @override
  void initState() {
    super.initState();
    fetchData(); // ดึงข้อมูลเมื่อเริ่มแอป
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tab_Success(),
      ],
    );
  }

  Widget tab_Success() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 320,
        height: 500,
        child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            final item = listData[index];
            return Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
              child: SizedBox(
                width: 300,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    // เช็คค่าสถานะ status_helmet เพื่อตัดสินใจว่าจะไปหน้าไหน
                    if (item['status_helmet'] == '0' ||
                        item['status_helmet'] == 0) {
                      // ไปหน้า Success Unpaid เมื่อ status_helmet เป็น 0
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GotwoSuccessUnpaid(), // ส่งข้อมูลไปหน้า Success Unpaid
                        ),
                      );
                    } else {
                      // ไปหน้า Success Paid สำหรับสถานะอื่นๆ
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GotwoSuccessPaid(item: item),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xfffbf8ff)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xff1a1c43)),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    "From: ${item['pick_up'] ?? 'Unknown'}",
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
                              "${item['status_helmet'] ?? 'Unknown'}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff1a1c43),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward, color: Color(0xff1a1c43)),
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
          },
        ),
      ),
    );
  }
}
