import 'package:flutter/material.dart';
import 'package:gotwo_app/tabs/tab-Confirm.dart';
import 'package:gotwo_app/tabs/tab_Cancel.dart';
import 'package:gotwo_app/tabs/tab_Request.dart';
import 'package:gotwo_app/tabs/tab_Success.dart';
import 'package:gotwo_app/tabs/tab_Totravel%20.dart';

class GotwoSatusrider extends StatefulWidget {
  const GotwoSatusrider({super.key});

  @override
  State<GotwoSatusrider> createState() => _GotwoSatusriderState();
}

class _GotwoSatusriderState extends State<GotwoSatusrider> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _backButton(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 80),
                      child: Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff1a1c43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              labelStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              labelColor: Color(0xff1a1c43),
              indicatorColor: Color(0xff1a1c43),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "Request",
                ),
                Tab(
                  text: "Confirm",
                ),
                Tab(
                  text: "ToTravel ",
                ),
                Tab(
                  text: "Success",
                ),
                Tab(
                  text: "Cancel",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    //Request
                    children: [
                      TabRequest(),
                    ],
                  ),
                  Column(
                    //Confirm
                    children: [
                      TabConfirm(),
                    ],
                  ),
                  Column(
                    //To travel
                    children: [
                      TabTotravel(),
                    ],
                  ),
                  Column(
                    //Success
                    children: [
                      TabSuccess(),
                    ],
                  ),
                  Column(
                    //Cancel
                    children: [
                      TabCancel(),
                    ],
                  ),
                ],
              ),
            ),
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
}
