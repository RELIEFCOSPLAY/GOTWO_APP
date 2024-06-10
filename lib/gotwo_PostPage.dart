import 'package:flutter/material.dart';

class GotwoPostpage extends StatefulWidget {
  const GotwoPostpage({super.key});

  @override
  State<GotwoPostpage> createState() => _GotwoPostpageState();
}

class _GotwoPostpageState extends State<GotwoPostpage> {
  TextEditingController searchController = TextEditingController();
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
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _backButton(),
                _aText(),
                _postButton(),
              ],
            ),
            _sarchField("Search", searchController),
            _cardBtn(),
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

  Widget _aText() {
    return const Text(
      "Post",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 30, color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
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
      padding: const EdgeInsets.all(12.0),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            debugPrint("Card");
          },
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Color(0xff1a1c43))))),
          child: const SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xff1a1c43),
                          size: 20.0,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "From: xxxx",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
                        ),
                      ],
                    ),
                    Text(
                      "Date: 24/03/2024 ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
                    ),
                    Text(
                      "Time: 10:30 AM",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_forward, color: Color(0xff1a1c43)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.tour,
                          color: Color(0xff1a1c43),
                          size: 20.0,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "To: xxxx",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "50 ",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff1a1c43)),
                        ),
                        Text(
                          "THB",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 10, color: Color(0xff1a1c43)),
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
  }
}
