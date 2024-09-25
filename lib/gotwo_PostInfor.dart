// ignore: unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_PostPage.dart';
import 'package:http/http.dart' as http;

class GotwoPostinfor extends StatefulWidget {
  const GotwoPostinfor({super.key});

  @override
  State<GotwoPostinfor> createState() => _GotwoPostinforState();
}

class _GotwoPostinforState extends State<GotwoPostinfor> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController commentController1 = TextEditingController();
  TextEditingController commentController2 = TextEditingController();

  static const List<String> list = <String>[
    'Select Location',
    'Mae Fah Luang(D1)',
    'Lotus Fah Thai',
  ];
  String dropdownPickup = list.first;
  String dropdownDrop = list.first;
  bool isChecked = false;

  //=======================================
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

  //---------------------------------------------------------------

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

  //----------------------------date-------------------------------
  // ฟังก์ชันนี้ใช้เพื่อแสดง DatePicker และเก็บค่าลงใน TextField
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // กำหนดวันที่เริ่มต้น
      lastDate: DateTime(2100), // กำหนดวันที่สิ้นสุด
    );
    if (picked != null) {
      setState(() {
        dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  //------------------------------time----------------------------------

// ฟังก์ชันนี้ใช้เพื่อแสดง TimePicker และเก็บค่าลงใน TextField
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  //--------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    loadLoginInfo();
  }

// ---------------URI----------------
  Uri url = Uri.parse('http://${Global.ip_8080}/gotwo/post_rider.php');

  Future<void> insert(
      String pickUp,
      String commentPick,
      String atDrop,
      String commentDrop,
      String date,
      String time,
      String price,
      String statusHelmet,
      String cusId,
      String riderId) async {
    var request = await http.post(url, body: {
      "action": "INSERT",
      "pick_up": pickUp,
      "comment_pick": commentPick,
      "at_drop": atDrop,
      "comment_drop": commentDrop,
      "date": date,
      "time": time,
      "price": price,
      "status_helmet": statusHelmet,
      "customer_id": cusId,
      "rider_id": riderId
    });

    if (request.statusCode == 200) {
      // ข้อมูลถูกส่งสำเร็จ
      print('Success: ${request.body}');
      print('Id Be ${userId}');
    } else {
      // มีปัญหาในการส่งข้อมูล
      print('Error: ${request.statusCode}, Body: ${request.body}');
    }
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
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                _backButton(),
                const SizedBox(
                  width: 60,
                ),
                _aText(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _inputBox(),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => GotwoPostPage(),
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

  Widget _aText() {
    return const Text(
      "Book Ride ",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _inputBox() {
    return Container(
      width: double.infinity,
      height: 567,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _bText(),
          const SizedBox(
            height: 10,
          ),
          _locationBox(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "date",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff1a1c43),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _inputFieldDate("00/00/0000", dateController),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "time",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff1a1c43),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _inputFieldTime("00:00", timeController),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _priceField("Set Price", priceController),
          _checkbox(),
          _postBtn(),
        ],
      ),
    );
  }

  Widget _bText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8, left: 40),
          child: Text(
            "Book Your Ride ",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 24,
              color: Color(0xff1a1c43),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _locationBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 220,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xff1a1c43))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xff1a1c43),
                    ),
                    "Pickup"),
              ),
              _dropdownPickup(),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: _commentField("Comment Pickup", commentController1),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xff1a1c43),
                    ),
                    "Drop"),
              ),
              _dropdownDrop(),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: _commentField("Comment Drop", commentController2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _commentField(
    String hintText,
    TextEditingController controller,
  ) {
    return SizedBox(
      height: 20,
      width: 200,
      child: TextField(
        textAlign: TextAlign.start,
        style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _inputFieldDate(
    String hintText,
    TextEditingController controller,
  ) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return SizedBox(
      height: 60,
      width: 140,
      child: TextField(
        readOnly: hintText ==
            "00/00/0000", // ทำให้ TextField ไม่สามารถพิมพ์ได้ ถ้าเป็น date
        onTap: hintText == "00/00/0000"
            ? () => _selectDate(context)
            : null, // แสดง DatePicker เมื่อคลิก
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xff1a1c43), fontSize: 16),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff1a1c43)),
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }

  Widget _inputFieldTime(
    String hintText,
    TextEditingController controller,
  ) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return SizedBox(
      height: 60,
      width: 140,
      child: TextField(
        readOnly: hintText ==
            "00:00", // ทำให้ TextField ไม่สามารถพิมพ์ได้ ถ้าเป็น time
        onTap: hintText == "00:00"
            ? () => _selectTime(context)
            : null, // แสดง TimePicker เมื่อคลิก
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xff1a1c43), fontSize: 16),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff1a1c43)),
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }

  Widget _inputField(
    String hintText,
    TextEditingController controller,
  ) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return SizedBox(
      height: 60,
      width: 140,
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xff1a1c43), fontSize: 16),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff1a1c43)),
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }

  Widget _priceField(
    String hintText,
    TextEditingController controller,
  ) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: SizedBox(
        child: TextField(
          style: const TextStyle(
            color: Color(0xff1a1c43),
          ),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xff1a1c43)),
            enabledBorder: border,
            focusedBorder: border,
            prefixIcon:
                const Icon(Icons.price_change, color: Color(0xff17C8B1)),
          ),
        ),
      ),
    );
  }

  Widget _checkbox() {
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: CheckboxListTile(
        title: const Text(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff1a1c43),
            ),
            "Bring your own a helmet"),
        checkColor: Colors.white,
        activeColor: const Color(0xff1a1c43),
        value: isChecked,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool? value) {
          setState(
            () {
              isChecked = value!;
            },
          );
        },
      ),
    );
  }

  Widget _dropdownPickup() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return Container(
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder: border,
          prefixIcon: const Icon(
            Icons.my_location,
            color: Color(0xff30E483),
          ),
        ),
        value: dropdownPickup,
        elevation: 16,
        style: const TextStyle(
          color: Color(0xff1a1c43),
          fontWeight: FontWeight.bold,
        ),
        borderRadius: BorderRadius.circular(18),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownPickup = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _dropdownDrop() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder: border,
          prefixIcon: const Icon(Icons.location_on, color: Color(0xffE51A1A)),
        ),
        value: dropdownDrop,
        elevation: 16,
        style: const TextStyle(
          color: Color(0xff1a1c43),
          fontWeight: FontWeight.bold,
        ),
        borderRadius: BorderRadius.circular(18),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownDrop = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _postBtn() {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: _snackBarnotification(),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        // String checked = isChecked.toString();
        String checked = isChecked ? "1" : "0";
        String cusId = "1";
        String? riderId = userId;

        if (dateController.text.isNotEmpty &&
            timeController.text.isNotEmpty &&
            priceController.text.isNotEmpty) {
          insert(
              dropdownPickup,
              commentController1.text,
              dropdownDrop,
              commentController2.text,
              dateController.text,
              timeController.text,
              priceController.text,
              checked,
              cusId,
              riderId!
              // isChecked ? "1" : "0",
              );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => GotwoPostPage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          debugPrint("Please fill in all required fields");
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 24),
        foregroundColor: Colors.blue,
        backgroundColor: const Color(0xff1a1c43),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 2),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Post",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }

  Widget _snackBarnotification() {
    if (dropdownPickup == "Select Location" &&
        commentController1.text == "" &&
        dropdownDrop == "Select Location" &&
        commentController2.text == "" &&
        dateController.text == "" &&
        timeController.text == "" &&
        priceController.text == "") {
      return Container(
        padding: const EdgeInsets.all(8),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.redAccent)),
        child: const Row(
          children: [
            SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Warning!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1a1c43),
                    ),
                  ),
                  Text(
                    "Please fill in all required fields",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff1a1c43),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
