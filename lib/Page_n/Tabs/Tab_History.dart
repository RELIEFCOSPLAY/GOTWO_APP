import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabHistory extends StatelessWidget {
  List testDate = [
    {
      'from': 'admin',
      'date': '24/03/2024',
      'time': '08:00',
      'to': 'K7',
      'price': 30,
      'status': 'Paid'
    },
  ];

  TabHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tab_History(),
      ],
    );
  }

  Widget _tab_History() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 320,
        height: 500,
        child: ListView.builder(
          itemCount: testDate.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
              child: SizedBox(
                width: 300,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("CardRequest ${testDate[index]['from']}");
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xfffbf8ff)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  const BorderSide(color: Color(0xff1a1c43))))),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xff1a1c43),
                                  size: 20.0,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "From: ${testDate[index]['from']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xff1a1c43)),
                                ),
                              ],
                            ),
                            Text(
                              "Date: ${testDate[index]['date']} ",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xff1a1c43)),
                            ),
                            Text(
                              "Time: ${testDate[index]['time']}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xff1a1c43)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.arrow_forward,
                            color: Color(0xff1a1c43)),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.tour,
                                  color: Color(0xff1a1c43),
                                  size: 20.0,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "To: ${testDate[index]['to']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xff1a1c43)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${testDate[index]['price']} ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20, color: Color(0xff1a1c43)),
                                ),
                                const Text(
                                  "THB",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff1a1c43)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
