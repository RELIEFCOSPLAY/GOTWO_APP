import 'package:flutter/material.dart';

class GotwoConRider extends StatefulWidget {
  final dynamic item; // รับข้อมูลจาก TabConfirm
  const GotwoConRider({super.key, required this.item});

  @override
  _GotwoConRider createState() => _GotwoConRider();
}

class _GotwoConRider extends State<GotwoConRider> {
  final formKey = GlobalKey<FormState>();

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

  Future<void> _showRejectDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('There is a request to join. Do you still want to delete this post?'),
              const SizedBox(height: 5),
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
                  child: const Text("Yes", style: TextStyle(color: Colors.white)),
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
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _userData(String name, String balance, String sex, String date, String email, String tel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(Icons.account_circle_outlined, size: 70),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.face, size: 20),
            const SizedBox(width: 5),
            Text(sex, style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.credit_card, size: 20),
            const SizedBox(width: 5),
            Text("$balance THB", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.date_range, size: 20),
            const SizedBox(width: 5),
            Text("Date : $date", style: const TextStyle(fontSize: 20)),
          ],
        ),
        // Email and telephone
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 20),
            const SizedBox(width: 5),
            Text("Email : $email", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone, size: 20),
            const SizedBox(width: 5),
            Text("Tel : $tel", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pick up",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.trip_origin),
              const SizedBox(width: 10),
              Expanded(
                child: Text(pickup),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            "Drop",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              const SizedBox(width: 10),
              Expanded(child: Text(dropoff)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statustext(String status) {
    return status == 'Paid'
        ? const Text(
            'Paid',
            style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
          )
        : const Text(
            'Unpaid',
            style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item; // ดึงข้อมูลที่ส่งมาจาก TabConfirm

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
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 5),
            _userData(
              "Name: ${item['rider_name'] ?? 'Unknown'}",
              "${item['price'] ?? '0'}",
              "Male",
              "${item['date'] ?? 'Unknown'}",
              "Email Rider",
              "0123456789",
            ),
            _statustext(item['status_payment'] ?? 'Unpaid'),
            const SizedBox(height: 5),
            _pickupDropoff(item['pick_up'] ?? 'Unknown', item['at_drop'] ?? 'Unknown'),
            const SizedBox(height: 5),
            const Text(
              "Bring your own a helmet.",
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
            const SizedBox(height: 5),
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
                  child: const Text("To travel", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _showRejectDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Reject", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

