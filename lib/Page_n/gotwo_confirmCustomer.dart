import 'package:flutter/material.dart';

class GotwoConCus extends StatefulWidget {
  const GotwoConCus({super.key});

  @override
  _GotwoConCus createState() => _GotwoConCus();
}

class _GotwoConCus extends State<GotwoConCus> {
  final _formKey = GlobalKey<FormState>();

  // ฟังก์ชันแสดง AlertDialog เมื่อยอมรับคำขอ
  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request'),
          content: const Text('Request has been accepted.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันแสดง AlertDialog เมื่อปฏิเสธคำขอ
  Future<void> _showRejectDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'There is a request to join. Do you still want to delete this post?'),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                  child:
                      const Text("Yes", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // แสดงข้อมูลผู้ใช้
  Widget _userData(String name, String balance, String sex, String date) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(Icons.account_circle_outlined, size: 60),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.face, size: 18),
            const SizedBox(width: 5),
            Text(sex, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.credit_card, size: 18),
            const SizedBox(width: 5),
            Text("$balance THB", style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.date_range, size: 18),
            const SizedBox(width: 5),
            Text("Date: $date", style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // แสดงสถานที่รับ-ส่ง
  Widget _pickupDropoff(String pickup, String dropoff) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.85,
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.trip_origin, color: Colors.green[800], size: 16),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(pickup, style: const TextStyle(fontSize: 14))),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Drop",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 16),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(dropoff, style: const TextStyle(fontSize: 14))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // แสดงข้อความสถานะ
  Widget _statustext(dynamic status) {
    if (status == 'Paid' || status == 1) {
      return const Text(
        'Paid',
        style: TextStyle(
            color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else if (status == 'Unpaid' || status == 0 || status == '0') {
      return const Text(
        'Unpaid',
        style: TextStyle(
            color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else {
      return const Text(
        'Unknown',
        style: TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // สมมติว่ามีการใช้ status_helmet ในการตัดสินใจ
    dynamic statusHelmet = 0; // แทนค่า status_helmet ที่คุณได้รับจริงๆ

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
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            _userData("Name Lastname", "50", "Male", "24/03/2024"),
            _statustext(statusHelmet),
            const SizedBox(height: 10),
            _pickupDropoff("Mae Fah Luang(D1)", "Lotus Fah Thai"),
            const SizedBox(height: 10),
            if (statusHelmet != 0)
              const Text(
                "Bring your own a helmet.",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _showDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text("To travel",
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _showRejectDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(
                height: 20), // เพิ่ม Space ด้านล่างเพื่อป้องกันการล้น
          ],
        ),
      ),
    );
  }
}
