import 'package:flutter/material.dart';

class GotwoCancel extends StatefulWidget {
  final dynamic item; // รับข้อมูลที่ส่งมา
  const GotwoCancel({super.key, required this.item});

  @override
  _GotwoCancel createState() => _GotwoCancel();
}

class _GotwoCancel extends State<GotwoCancel> {
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

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    int _currentRating = int.parse(item['review']);
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C43),
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
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.account_circle_outlined, size: 50),
                ),
                Text(
                  "${item['rider_name'] ?? 'Unknown'}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Rate",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    for (var i = 1; i <= 5; i++)
                      Icon(
                        Icons.star,
                        size: 12,
                        color:
                            i <= _currentRating ? Colors.yellow : Colors.grey,
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          item['rider_gender'] == 'male'
                              ? Icons.male // Icon for Male
                              : item['rider_gender'] == 'female'
                                  ? Icons.female // Icon for Female
                                  : Icons
                                      .help_outline, // Default icon if gender is unknown or other
                          color: item['rider_gender'] == 'male'
                              ? Colors.blue
                              : item['rider_gender'] == 'female'
                                  ? Colors.pink
                                  : Colors.grey,
                        ),
                        const SizedBox(width: 5), // Space between icon and text
                        Text(
                          "${item['rider_gender'] ?? 'Unknown'}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.credit_card, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      "${item['price'] ?? 'Unknown'} THB",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.date_range, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      "Date: ${item['date'] ?? 'Unknown'}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: TextButton.icon(
                    onPressed: item['pay'] == '1' || item['pay'] == 1
                        ? () {
                            _showPaidPopup(context);
                          }
                        : null, // ถ้าเป็น "Unpaid" ปุ่มจะกดไม่ได้
                    icon: item['pay'] == '1' || item['pay'] == 1
                        ? const Icon(Icons.visibility,
                            color: Colors.green, size: 16) // ไอคอนสำหรับ "Paid"
                        : const Icon(Icons.visibility_off,
                            color: Colors.red,
                            size: 16), // ไอคอนสำหรับ "Unpaid"
                    label: Text(
                      item['pay'] == '1' || item['pay'] == 1
                          ? "Paid"
                          : "Unpaid", // ถ้าเป็น 1 แสดง "Paid", ถ้าเป็น 0 แสดง "Unpaid"
                      style: TextStyle(
                        fontSize: 12,
                        color: item['pay'] == '1' || item['pay'] == 1
                            ? Colors.green // สีเขียวสำหรับ "Paid"
                            : Colors.red, // สีแดงสำหรับ "Unpaid"
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      item['pay'] == '1' || item['pay'] == 1
                          ? Icons.email
                          : null,
                      color: const Color(0xFF1A1C43),
                    ),
                    const SizedBox(width: 5), // Space between icon and text
                    Text(
                      item['pay'] == '1' || item['pay'] == 1
                          ? "${item['rider_email'] ?? 'Unknown'}"
                          : "", // ถ้าเป็น 1 แสดง "'rider_email", ถ้าเป็น 0 ไม่แสดง
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1A1C43), // Red for "Unpaid"
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      item['pay'] == '1' || item['pay'] == 1
                          ? Icons.phone
                          : null,
                      color: const Color(0xFF1A1C43),
                    ),
                    const SizedBox(width: 5), // Space between icon and text
                    Text(
                      item['pay'] == '1' || item['pay'] == 1
                          ? "${item['rider_tel'] ?? 'Unknown'}"
                          : "", // ถ้าเป็น 1 แสดง "'rider_email", ถ้าเป็น 0 ไม่แสดง
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1A1C43), // Red for "Unpaid"
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.trip_origin,
                              color: Colors.green[800], size: 16),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item['pick_up'] ?? 'Unknown',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // แสดงคอมเมนต์ที่ได้รับจาก item
                      Text(
                        "${item['comment_pick'] ?? 'No comment'}", // แสดงคอมเมนต์ pick up
                        style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Drop",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.red, size: 16),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item['at_drop'] ?? 'Unknown',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // แสดงคอมเมนต์ที่ได้รับจาก item
                      Text(
                        "${item['comment_drop'] ?? 'No comment'}", // แสดงคอมเมนต์ drop
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Reason',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 10),
                // Text(
                //   item['status_helmet'] == '1' || item['status_helmet'] == 1
                //       ? "There is a helmet for you" // If 1, show this message
                //       : "Bring your own a helmet", // If 0, show this message
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: item['status_helmet'] == '1' ||
                //             item['status_helmet'] == 1
                //         ? Colors.green // Green for "There is a helmet for you"
                //         : Colors.red, // Red for "Bring your own a helmet"
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
