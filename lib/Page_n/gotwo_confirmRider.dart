import 'package:flutter/material.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:http/http.dart' as http;

class GotwoConRider extends StatefulWidget {
  final dynamic item;
  const GotwoConRider({super.key, required this.item});

  @override
  _GotwoConRider createState() => _GotwoConRider();
}

class _GotwoConRider extends State<GotwoConRider> {
  TextEditingController rejectComment = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final url =
      Uri.parse('http://${Global.ip_8080}/gotwo/update_statusRaider.php');
  Future<void> update_status_Accept(
    String status,
    String status_post_id,
    String action,
    String no_comment,
    String pay,
  ) async {
    var request = await http.post(url, body: {
      "action": action,
      "status": status,
      "status_post_id": status_post_id,
      "Comment": no_comment,
      "pay": pay,
    });

    if (request.statusCode == 200) {
      // ข้อมูลถูกส่งสำเร็จ
      print('Success: ${request.body}');
    } else {
      // มีปัญหาในการส่งข้อมูล
      print('Error: ${request.statusCode}, Body: ${request.body}');
    }
  }

  Future<void> update_status_Cancel(
    String status,
    String status_post_id,
    String action,
    String rejectComment,
    String pay,
  ) async {
    var request = await http.post(url, body: {
      "action": action,
      "status": status,
      "status_post_id": status_post_id,
      "Comment": rejectComment,
      "pay": pay,
    });

    if (request.statusCode == 200) {
      // ข้อมูลถูกส่งสำเร็จ
      print('Success: ${request.body}');
    } else {
      // มีปัญหาในการส่งข้อมูล
      print('Error: ${request.statusCode}, Body: ${request.body}');
    }
  }

  Future<void> _showDialog() async {
    final item = widget.item;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('To Travel'),
          content: const Text('Are you sure to To Travel?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    String pay = "0"; // กำหนดค่าเริ่มต้น
                    if (item['pay'].toString() == "1" || item['pay'] == 1) {
                      pay = "1";
                    } else if (item['pay'].toString() == "0" ||
                        item['pay'] == 0) {
                      pay = "0";
                    }
                    String no_comment = "No comment";
                    String action = "accept";
                    String status = '3';
                    String status_post_id =
                        '${item['status_post_id'] ?? 'Unknown'}';
                    update_status_Accept(
                        status, status_post_id, action, no_comment,pay);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                  child:
                      const Text("back", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRejectDialog() async {
    final item = widget.item;
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
                controller: rejectComment,
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
                    String pay = "0"; // กำหนดค่าเริ่มต้น
                    if (item['pay'].toString() == "1" || item['pay'] == 1) {
                      pay = "2";
                    } else if (item['pay'].toString() == "0" ||
                        item['pay'] == 0) {
                      pay = "4";
                    }
                    String action = "cancel";
                    String status = '5';
                    String status_post_id =
                        '${item['status_post_id'] ?? 'Unknown'}';
                    update_status_Cancel(status, status_post_id, action,
                        rejectComment.text, pay);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
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
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
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
                Text(
                  item['pay'] == '1' || item['pay'] == 1
                      ? "Paid"
                      : "Unpaid", // ถ้าเป็น 1 แสดง "Paid", ถ้าเป็น 0 แสดง "Unpaid"
                  style: TextStyle(
                    fontSize: 12,
                    color: item['pay'] == '1' || item['pay'] == 1
                        ? Colors.green // Green for "Paid"
                        : Colors.red, // Red for "Unpaid"
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (item['pay'] == '1' || item['pay'] == 1)
                          ? () async {
                              _showDialog();
                            }
                          : null, // ปุ่มจะกดไม่ได้เมื่อ onPressed เป็น null
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (item['pay'] == '1' ||
                                item['pay'] == 1)
                            ? Colors.green
                            : Colors
                                .grey, // ปุ่มจะเปลี่ยนเป็นสีเทาเมื่อ pay == 0
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "To Travel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _showRejectDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
