import 'package:flutter/material.dart';
import 'package:gotwo_app/global_ip.dart';

class GotwoSuccessPaid extends StatefulWidget {
  final dynamic item; // รับข้อมูลที่ส่งมา
  const GotwoSuccessPaid({super.key, required this.item});

  @override
  _GotwoSuccessPaid createState() => _GotwoSuccessPaid();
}

class _GotwoSuccessPaid extends State<GotwoSuccessPaid> {
  void _showPaidPopup(BuildContext context) {
    final item = widget.item;
    String imgMoneyslip = 'http://${Global.ip_8080}/${item['img_qr_admin']}';
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
              item['img_qr_admin'] != null &&
                      item['img_qr_admin'].trim().isNotEmpty
                  ? Image.network(
                      imgMoneyslip,
                      fit: BoxFit.cover, // ปรับให้รูปภาพเติมเต็มพื้นที่
                      width: 200, // กำหนดขนาดความกว้าง
                      height: 200, // กำหนดขนาดความสูง
                    )
                  : const Icon(Icons.person),
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
    String imgShow = 'http://${Global.ip_8080}/${item['img_profile']}';
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
                const SizedBox(
                  height: 5,
                ),
                CircleAvatar(
                  minRadius: 25,
                  maxRadius: 40,
                  backgroundColor: Colors.white,
                  child: item!['img_profile'] != null
                      ? ClipOval(
                          // ใช้ ClipOval เพื่อครอบภาพให้เป็นวงกลม
                          child: Image.network(
                            imgShow,
                            fit: BoxFit.cover, // ปรับให้รูปภาพเติมเต็มพื้นที่
                            width: 80, // กำหนดขนาดความกว้าง
                            height: 80, // กำหนดขนาดความสูง
                          ),
                        )
                      : const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 5,
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
                    onPressed: item['pay'] == '5'
                        ? () {
                            _showPaidPopup(context);
                          }
                        : null, // ถ้าไม่ใช่ "Complete" ปุ่มจะกดไม่ได้
                    icon: item['pay'] == '0'
                        ? const Icon(Icons.visibility_off,
                            color: Colors.red, size: 16) // "Unpaid"
                        : item['pay'] == '1'
                            ? const Icon(Icons.visibility_off,
                                color: Colors.green, size: 16) // "Paid"
                            : item['pay'] == '2'
                                ? const Icon(Icons.visibility_off,
                                    color: Colors.greenAccent,
                                    size: 16) // "Verify"
                                : item['pay'] == '3'
                                    ? const Icon(Icons.visibility_off,
                                        color: Colors.blue,
                                        size: 16) // "Pending"
                                    : item['pay'] == '4'
                                        ? const Icon(Icons.visibility,
                                            color: Colors.orange,
                                            size: 16) // "Refund"
                                        : item['pay'] == '5'
                                            ? const Icon(Icons.visibility,
                                                color: Colors.lightBlue,
                                                size: 16) // "Complete"
                                            : item['pay'] == '6'
                                                ? const Icon(
                                                    Icons.visibility_off,
                                                    color: Colors.redAccent,
                                                    size: 16) // "Cancel"
                                                : const Icon(
                                                    Icons.visibility_off,
                                                    color: Colors.grey,
                                                    size: 16), // Default ไอคอน
                    label: Text(
                      item['pay'] == '0'
                          ? "Unpaid"
                          : item['pay'] == '1'
                              ? "Paid"
                              : item['pay'] == '2'
                                  ? "Verify"
                                  : item['pay'] == '3'
                                      ? "Pending"
                                      : item['pay'] == '4'
                                          ? "Refund"
                                          : item['pay'] == '5'
                                              ? "Complete"
                                              : item['pay'] == '6'
                                                  ? "Cancel"
                                                  : "Unknown", // กรณีที่ไม่ตรงกับเงื่อนไขใดๆ
                      style: TextStyle(
                        fontSize: 12,
                        color: item['pay'] == '0'
                            ? Colors.red // Red for "Unpaid"
                            : item['pay'] == '1'
                                ? Colors.green // Green for "Paid"
                                : item['pay'] == '2'
                                    ? Colors
                                        .green[200] // Green[200] for "Verify"
                                    : item['pay'] == '3'
                                        ? Colors.blue // Blue for "Pending"
                                        : item['pay'] == '4'
                                            ? Colors
                                                .orange // Orange for "Refund"
                                            : item['pay'] == '5'
                                                ? Colors.blue[
                                                    200] // Blue[200] for "Complete"
                                                : item['pay'] == '6'
                                                    ? Colors.red[
                                                        400] // Red[400] for "Cancel"
                                                    : Colors
                                                        .grey, // Grey for "Unknown"
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
                const SizedBox(height: 10),
                Text(
                  item['status_helmet'] == '1' || item['status_helmet'] == 1
                      ? "There is a helmet for you" // If 1, show this message
                      : "Bring your own a helmet", // If 0, show this message
                  style: TextStyle(
                    fontSize: 14,
                    color: item['status_helmet'] == '1' ||
                            item['status_helmet'] == 1
                        ? Colors.green // Green for "There is a helmet for you"
                        : Colors.red, // Red for "Bring your own a helmet"
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
