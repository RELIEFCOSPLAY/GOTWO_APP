import 'package:flutter/material.dart';

class GotwoSuccessUnpaid extends StatefulWidget {
  const GotwoSuccessUnpaid({super.key});

  @override
  _GotwoSuccessUnpaid createState() => _GotwoSuccessUnpaid();
}

class _GotwoSuccessUnpaid extends State<GotwoSuccessUnpaid> {
  final _formKey = GlobalKey<FormState>();

  int _currentRating = 0; // Initial rating value

  Widget _userData(String name, String balance, String sex, String date,
      String email, String tel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(Icons.account_circle_outlined, size: 70),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Rate",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            for (var i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentRating =
                        i; // Update the rating when a star is tapped
                  });
                },
                child: Icon(
                  Icons.star,
                  color: i <= _currentRating ? Colors.yellow : Colors.grey,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.face,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(sex, style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.credit_card,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text("$balance THB", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.date_range,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text("Date: $date", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ],
    );
  }

  Widget _pickupDropoff(String pickup, String dropoff) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pick up",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.trip_origin, color: Colors.green[800]),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    pickup,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "comment",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              "Drop",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    dropoff,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "comment",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันแสดงสถานะโดยไม่แปลงค่า 0 เป็น "Unpaid"
  Widget _SuccessText(dynamic status) {
    // แสดงข้อความ "Paid" หรือ "Unpaid" ตามสถานะ
    return (status == 'Paid' || status == 1)
        ? const Text(
            'Paid',
            style: TextStyle(
                color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          )
        : const Text(
            'Unpaid',
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          );
  }

  @override
  Widget build(BuildContext context) {
    // สมมติว่ามี status ที่รับมาจากข้อมูลจริง เช่น 0
    dynamic status = 0; // ใช้ค่าสถานะที่เป็น 0 เพื่อทดสอบแสดง "Unpaid"

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C43),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // เพิ่มการทำงานของปุ่มย้อนกลับ
          },
        ),
        title: const Text('Success', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            _userData("Name Lastname", "50", "Male", "24/03/2024",
                "Email Rider", "0123456789"),
            const SizedBox(height: 10),
            _SuccessText(status), // ส่ง status เป็น 0 เพื่อแสดง "Unpaid"
            const SizedBox(height: 10),
            _pickupDropoff("Mae Fah Luang(D1)", "Lotus Fah Thai"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
