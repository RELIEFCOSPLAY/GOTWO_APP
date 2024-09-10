import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GotwoPostpage extends StatefulWidget {
  const GotwoPostpage({super.key});

  @override
  State<GotwoPostpage> createState() => _GotwoPostpageState();
}

class _GotwoPostpageState extends State<GotwoPostpage> {
  List<dynamic> listData = [];
  List<dynamic> filteredList = [];

  // ฟังก์ชันดึงข้อมูลจาก API
  Future<void> fetchData() async {
    final String url =
        "http://192.168.1.139:8080/gotwo/get_post.php"; // URL ของ API
    try {
      final response = await http.get(Uri.parse(url));

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
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // ดึงข้อมูลเมื่อเริ่มแอป
  }

  // ฟังก์ชันสำหรับการค้นหา
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = listData; // ถ้าไม่มีการพิมพ์ค้นหา ให้แสดงข้อมูลทั้งหมด
    } else {
      results = listData
          .where((item) =>
              item["pick_up"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              item["at_drop"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _backButton(),
                    const Text(
                      "Post",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff1a1c43),
                          fontWeight: FontWeight.bold),
                    ),
                    _postButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _page(),
      ),
    );
  }

  // ปุ่มย้อนกลับ
  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("back");
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: Color(0xff1a1c43),
      ),
    );
  }

  // ปุ่มสำหรับโพสต์
  Widget _postButton() {
    return GestureDetector(
      onTap: () {
        listData;
      },
      child: const Icon(
        Icons.add_circle,
        size: 40,
      ),
    );
  }

  // แสดงผลข้อมูลและช่องค้นหา
  Widget _page() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _cardAndSearch(),
          ],
        ),
      ),
    );
  }

  // ค้นหาและแสดงข้อมูล
  Widget _cardAndSearch() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));
    return SizedBox(
      width: 320,
      height: 550,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              style: const TextStyle(
                color: Color(0xff1a1c43),
              ),
              decoration: InputDecoration(
                labelText: 'Search',
                hintStyle: const TextStyle(color: Color(0xff1a1c43)),
                enabledBorder: border,
                focusedBorder: border,
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color(0xff1a1c43),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredList.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Container(
                        width: 300,
                        height: 100,
                        key: ValueKey(item["pick_up"]),
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: const WidgetStatePropertyAll(
                                  Color(0xfffbf8ff)),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color(0xff1a1c43))))),
                          onPressed: () {
                            debugPrint("CardRequest ${item['pick_up']}");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Color(0xff1a1c43),
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Pick Up: ${item['pick_up']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff1a1c43)),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Date: ${item['date']} ",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff1a1c43)),
                                  ),
                                  Text(
                                    "Time: ${item['time']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff1a1c43)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.arrow_forward,
                                  color: Color(0xff1a1c43)),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        color: Color(0xff1a1c43),
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Drop: ${item['at_drop']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff1a1c43)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${item['price']} ",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff1a1c43)),
                                      ),
                                      const Text(
                                        "THB",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff1a1c43)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : const Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff1a1c43),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
