import 'package:flutter/material.dart';

class TabTotravel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tab_Totravel(),
        _tab_Totravel(),
      ],
    );
  }

  Widget _tab_Totravel() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 8),
      child: SizedBox(
        width: 300,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            debugPrint("CardTotravel");
          },
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Color(0xfffbf8ff)),
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
