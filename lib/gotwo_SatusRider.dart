import 'package:flutter/material.dart';
import 'package:gotwo_app/gotwo_DashbordRider.dart';
// ignore: unused_import
import 'package:gotwo_app/tabs/tab-Confirm.dart';
// ignore: unused_import
import 'package:gotwo_app/tabs/tab_Cancel.dart';
// ignore: unused_import
import 'package:gotwo_app/tabs/tab_Request.dart';
// ignore: unused_import
import 'package:gotwo_app/tabs/tab_Success.dart';
// ignore: unused_import
import 'package:gotwo_app/tabs/tab_Totravel%20.dart';
import 'package:gotwo_app/tabs/testCancel.dart';
import 'package:gotwo_app/tabs/testConfirm.dart';
import 'package:gotwo_app/tabs/testRequest.dart';
import 'package:gotwo_app/tabs/testSuccess.dart';
import 'package:gotwo_app/tabs/testTotravel.dart';

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
                      padding: EdgeInsets.only(left: 60),
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
        body: const Column(
          children: [
            TabBar(
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
    return IconButton(
      onPressed: () {
        debugPrint("back");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const GotwoDashbordrider(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: Color(0xff1a1c43),
      ),
    );
  }
}
