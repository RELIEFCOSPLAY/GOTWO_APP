import 'package:flutter/material.dart';

class GotwoPostpage extends StatefulWidget {
  const GotwoPostpage({super.key});

  @override
  State<GotwoPostpage> createState() => _GotwoPostpageState();
}

class _GotwoPostpageState extends State<GotwoPostpage> {
  TextEditingController searchController = TextEditingController();
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
  Widget build(Object context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _backButton(),
                    const Text(
                      "Post",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff1a1c43),
                          fontWeight: FontWeight.bold),
                    ),
                    _postButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _sarchField("Search", searchController),
            _cardBtn(),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("back");
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: Color(0xff1a1c43),
      ),
    );
  }

  Widget _postButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("Post");
      },
      child: const Icon(
        Icons.add_circle,
        size: 40,
      ),
    );
  }

  Widget _sarchField(String hintText, TextEditingController controller) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
      child: SizedBox(
        child: TextField(
          style: const TextStyle(
            color: Color(0xff1a1c43),
          ),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xff1a1c43)),
            enabledBorder: border,
            focusedBorder: border,
            // prefixIcon: Icon(
            //   Icons.search,
            // ),
            suffixIcon: GestureDetector(
              onTap: () {
                debugPrint("Search : ${searchController.text}");
                
              },
              child: const Icon(
                Icons.search,
                color: Color(0xff1a1c43),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardBtn() {
    return SizedBox(
      width: 320,
      height: 450,
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
                            side: const BorderSide(color: Color(0xff1a1c43))))),
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
    );
  }
}
