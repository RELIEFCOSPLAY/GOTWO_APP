import 'package:flutter/material.dart';

class GotwoTotravel extends StatefulWidget {
  const GotwoTotravel({super.key});

  @override
  _GotwoTotravel createState() => _GotwoTotravel();
}

class _GotwoTotravel extends State<GotwoTotravel> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _showRejectDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'There is a request to join. Do you still want to delete this post?',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
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
                    // Add your logic for confirmation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      const Text("Yes", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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

  Widget _userData(String name, int rate, String balance, String sex,
      String date, String email, String tel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(Icons.account_circle_outlined, size: 70),
        ),
        const SizedBox(height: 1),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Rate",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 5),
            for (var i = 0; i < 5; i++)
              Icon(
                Icons.star,
                color: i < rate ? Colors.yellow : Colors.grey,
              ),
          ],
        ),
        const SizedBox(height: 1),
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
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.credit_card,
              size: 20,
            ),
            const SizedBox(width: 1),
            Text("$balance THB", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.date_range,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text("Date : $date", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text("Email : $email", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text("Tel : $tel", style: const TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 1),
      ],
    );
  }

  Widget _pickupDropoff(String pickup, String dropoff) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            Text(
              "Pick up",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 1),
            Row(
              children: [
                Icon(Icons.trip_origin, color: Colors.green[700]),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(pickup,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 1),
            const Text(
              "comment",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 1),
            Text(
              "Drop",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 1),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(dropoff,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 1),
            const Text(
              "comment",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C43),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text('To travel', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            _userData("Name Lastname", 5, "50", "Male", "24/03/2024",
                "Email Rider", "0123456789"),
            const SizedBox(height: 20),
            _pickupDropoff("Mae Fah Luang(D1)", "Lotus Fah Thai"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                _showRejectDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
