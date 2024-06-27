import 'package:flutter/material.dart';

class GotwoPostpage extends StatefulWidget {
  const GotwoPostpage({super.key});

  @override
  State<GotwoPostpage> createState() => _GotwoPostpageState();
}

class _GotwoPostpageState extends State<GotwoPostpage> {
  final List<Map<String, dynamic>> testDate = [
    {
      "id": 1,
      'from': 'hat',
      'date': '01/12/2077',
      'time': '08:00',
      'to': 'K7',
      'price': 30,
      'status': 'Paid'
    },
    {
      "id": 2,
      'from': 'bag',
      'date': '05/11/2078',
      'time': '09:27',
      'to': 'E2',
      'price': 50,
      'status': 'Unpaid'
    },
    {
      "id": 3,
      'from': 'sock',
      'date': '10/10/2079',
      'time': '10:30',
      'to': 'M1',
      'price': 120,
      'status': 'Paid'
    },
  ];
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = testDate;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = testDate;
    } else {
      results = testDate
          .where(
            (user) => user["from"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
  }

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
            _cardAndSearch(),
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

  Widget _cardAndSearch() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));
    return SizedBox(
      width: 320,
      height: 550,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              style: const TextStyle(
                color: Color(0xff1a1c43),
              ),
              decoration: InputDecoration(
                labelText: 'Search',
                hintStyle: const TextStyle(color: Color(0xff1a1c43)),
                enabledBorder: border,
                focusedBorder: border,
                // prefixIcon: Icon(
                //   Icons.search,
                // ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color(0xff1a1c43),
                ),
              ),
            ),
          ),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Container(
                      width: 300,
                      height: 100,
                      key: ValueKey(_foundUsers[index]["id"]),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Color(0xfffbf8ff)),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: Color(0xff1a1c43))))),
                        onPressed: () {
                          debugPrint(
                              "CardRequest ${_foundUsers[index]['from']}");
                        },
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
                                      "From: ${_foundUsers[index]['from']}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff1a1c43)),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Date: ${_foundUsers[index]['date']} ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xff1a1c43)),
                                ),
                                Text(
                                  "Time: ${_foundUsers[index]['time']}",
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
                                      "To: ${_foundUsers[index]['to']}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff1a1c43)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${_foundUsers[index]['price']} ",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 20,
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff1a1c43),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
