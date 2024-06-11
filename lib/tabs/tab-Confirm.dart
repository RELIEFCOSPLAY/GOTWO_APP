import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabConfirm extends StatelessWidget {
  List testDate = [
    {
      'from': 'hat',
      'date': '01/12/2077',
      'time': '08:00',
      'to': 'K7',
      'price': 30,
      'status': 'Paid'
    },
    {
      'from': 'bag',
      'date': '05/11/2078',
      'time': '09:27',
      'to': 'E2',
      'price': 50,
      'status': 'Unpaid'
    },
    {
      'from': 'sock',
      'date': '10/10/2079',
      'time': '10:30',
      'to': 'M1',
      'price': 120,
      'status': 'Paid'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tab_Confirm(),
      ],
    );
  }

  Widget tab_Confirm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 320,
        height: 500,
        child: ListView.builder(
          itemCount: testDate.length,
          itemBuilder: (context, index) {
            if (testDate[index]['status'] == "Paid") {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("CardConfirm");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xfffbf8ff)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: Color(0xff1a1c43))))),
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
                          const Icon(Icons.arrow_forward, color: Color(0xff1a1c43)),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      "${testDate[index]['price']} ",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff1a1c43)),
                                    ),
                                    Text(
                                      "${testDate[index]['status']}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff1a1c43)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "${testDate[index]['status']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 10, color: Color(0xff06D258)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (testDate[index]['status'] == "Unpaid") {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("CardConfirm2");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xfffbf8ff)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(
                                    color: Color(0xff1a1c43))))),
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
                          const Icon(Icons.arrow_forward, color: Color(0xff1a1c43)),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      "${testDate[index]['price']} ",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff1a1c43)),
                                    ),
                                    const Text(
                                      "THB",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff1a1c43)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "${testDate[index]['status']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 10, color: Color(0xffE51A1A)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
