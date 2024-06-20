import 'package:flutter/material.dart';

class GotwoTotravel extends StatefulWidget {
  const GotwoTotravel({super.key});

  @override
  _GotwoTotravel createState() => _GotwoTotravel();
}

class _GotwoTotravel extends State<GotwoTotravel> {
  final _formKey = GlobalKey<FormState>();

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
                // go to next page
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Confirm()),
                // );
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
          // title: const Text('Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'There is a request to join. Do you still want to delete this post?'),
              const SizedBox(height: 10),
              // add black textfield
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
                    // close dialog
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      // set border radius to 0
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
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Rate", style: TextStyle(fontSize: 20)),
            const SizedBox(width: 5),
            for (var i = 0; i < 5; i++)
              Icon(
                Icons.star,
                color: i < rate ? Colors.yellow : Colors.grey,
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
            Text("Date : $date", style: const TextStyle(fontSize: 20)),
          ],
        ),
        // show email and tel
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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

        const SizedBox(height: 40),
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
            Text(
              "Pick up",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.trip_origin,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(pickup),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Drop",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 10),
                Expanded(child: Text(dropoff)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // widget of status
  Widget _statustext(String status) {
    return status == 'Paid'
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1C43),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text('To travel', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      // backgroundColor: const Color(0xFF1C2C5E),
      body: Center(
        child: Column(
          children: <Widget>[
            // add border raidus to the container
            const SizedBox(height: 20),
            _userData("Name Lastname", 5, "50", "Male", "24/03/2024",
                "Email Rider", "0123456789"),
            const SizedBox(height: 20),
            _pickupDropoff("Mae Fah Luang(D1)", "Lotus Fah Thai"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
          ],
        ),
      ),
    );
  }
}
