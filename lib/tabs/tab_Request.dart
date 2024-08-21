import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabRequest extends StatelessWidget {
  List testDate = [
    {
      'from': 'hat',
      'date': '01/12/2077',
      'time': '08:00',
      'to': 'K7',
      'price': 30
    },
    {
      'from': 'bag',
      'date': '05/11/2078',
      'time': '09:27',
      'to': 'E2',
      'price': 50
    },
    {
      'from': 'sock',
      'date': '10/10/2079',
      'time': '10:30',
      'to': 'M1',
      'price': 120
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tab_Request(),
      ],
    );
  }

  Widget _tab_Request() {
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

  // Widget _tab_Request() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 8),
  //     child: SizedBox(
  //       width: 300,
  //       height: 100,
  //       child: ElevatedButton(
  //         onPressed: () {
  //           debugPrint("CardRequest");
  //         },
  //         style: ButtonStyle(
  //             backgroundColor: const WidgetStatePropertyAll(Color(0xfffbf8ff)),
  //             shape: WidgetStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(18.0),
  //                     side: const BorderSide(color: Color(0xff1a1c43))))),
  //         child: const SizedBox(
  //           width: double.infinity,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.location_on,
  //                         color: Color(0xff1a1c43),
  //                         size: 20.0,
  //                       ),
  //                       SizedBox(width: 5),
  //                       Text(
  //                         "From: xxxx",
  //                         textAlign: TextAlign.center,
  //                         style:
  //                             TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
  //                       ),
  //                     ],
  //                   ),
  //                   Text(
  //                     "Date: 24/03/2024 ",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
  //                   ),
  //                   Text(
  //                     "Time: 10:30 AM",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Icon(Icons.arrow_forward, color: Color(0xff1a1c43)),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.tour,
  //                         color: Color(0xff1a1c43),
  //                         size: 20.0,
  //                       ),
  //                       SizedBox(width: 5),
  //                       Text(
  //                         "To: xxxx",
  //                         textAlign: TextAlign.center,
  //                         style:
  //                             TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       Text(
  //                         "50 ",
  //                         textAlign: TextAlign.center,
  //                         style:
  //                             TextStyle(fontSize: 20, color: Color(0xff1a1c43)),
  //                       ),
  //                       Text(
  //                         "THB",
  //                         textAlign: TextAlign.center,
  //                         style:
  //                             TextStyle(fontSize: 10, color: Color(0xff1a1c43)),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
