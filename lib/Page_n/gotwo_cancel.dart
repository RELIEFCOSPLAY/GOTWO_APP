import 'package:flutter/material.dart';

class GotwoCancel extends StatefulWidget {
  final dynamic item; // รับข้อมูลที่ส่งมา
  const GotwoCancel({super.key, required this.item});

  @override
  _GotwoCancel createState() => _GotwoCancel();
}

class _GotwoCancel extends State<GotwoCancel> {
  int _currentRating = 5; // Initial rating value

  Widget _pickupDropoff(String pickup, String dropoff) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pick up",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(
                Icons.trip_origin,
                color: Colors.green[800],
                size: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  pickup,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Drop",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  dropoff,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
        // Star Rating Row
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(email, style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(tel, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item; // รับข้อมูลที่ส่งมาจากหน้าก่อนหน้า

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C43),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Cancel', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // เพิ่ม SingleChildScrollView เพื่อให้สามารถเลื่อนขึ้นลงได้
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              _userData(
                item['rider_name'] ?? "Name Lastname",
                item['price'] ?? "50",
                "${item['rider_gender'] ?? 'Unknown'}",
                item['date'] ?? "24/03/2024",
                "Email Rider",
                "0123456789",
              ),
              const SizedBox(height: 10),
              _pickupDropoff(
                item['pick_up'] ?? "Mae Fah Luang(D1)",
                item['at_drop'] ?? "Lotus Fah Thai",
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBE2EF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Reason',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 1),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
