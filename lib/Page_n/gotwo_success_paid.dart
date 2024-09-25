import 'package:flutter/material.dart';

class GotwoSuccessPaid extends StatefulWidget {
  final dynamic item; // รับข้อมูลที่ส่งมา
  const GotwoSuccessPaid({super.key, required this.item});

  @override
  _GotwoSuccessPaid createState() => _GotwoSuccessPaid();
}

class _GotwoSuccessPaid extends State<GotwoSuccessPaid> {
  int _currentRating = 5; // Initial rating value

  Widget _userData(String name, String balance, String sex, String date,
      String email, String tel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(Icons.account_circle_outlined, size: 60),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // Star Rating Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Rate",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            for (var i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentRating = i; // Update the rating when a star is tapped
                  });
                },
                child: Icon(
                  Icons.star,
                  size: 16,
                  color: i <= _currentRating ? Colors.yellow : Colors.grey,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.face, size: 18),
            const SizedBox(width: 5),
            Text(sex, style: const TextStyle(fontSize: 10)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.credit_card, size: 18),
            const SizedBox(width: 5),
            Text("$balance THB", style: const TextStyle(fontSize: 10)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.date_range, size: 18),
            const SizedBox(width: 5),
            Text("Date: $date", style: const TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }

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
                child: Text(
                  pickup,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Drop",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  dropoff,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPaidPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Money slip',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1C43),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.image,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Color(0xFF1A1C43),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusButton(String status) {
    return TextButton(
      onPressed: () {
        _showPaidPopup(context); // Show popup when button is pressed
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          status == 'Paid' ? Colors.green : Colors.red,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
          Icon(
            Icons.remove_red_eye,
            color: status == 'Paid' ? Colors.green : Colors.red,
            size: 18,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item; // ดึงข้อมูลที่ส่งมาจากหน้าก่อน

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
        title: const Text('Success', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              _userData(
                item['rider_name'] ?? "Name Lastname",
                item['price'] ?? "50",
                "${item['rider_gender'] ?? 'Unknown'}",
                item['date'] ?? "24/03/2024",
                "Email Rider",
                "0123456789",
              ),
              _statusButton(item['status_payment'] ?? "Paid"),
              const SizedBox(height: 10),
              _pickupDropoff(item['pick_up'] ?? "Mae Fah Luang(D1)", item['at_drop'] ?? "Lotus Fah Thai"),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
