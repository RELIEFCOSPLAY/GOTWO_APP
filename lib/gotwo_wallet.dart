import 'package:flutter/material.dart';
import 'package:gotwo_app/Tabs/Tab_History.dart';
import 'package:gotwo_app/Tabs/Tab_Pending.dart';

class GotwoWallet extends StatefulWidget {
  const GotwoWallet({super.key});

  @override
  State<GotwoWallet> createState() => _GotwoWalletState();
}

class _GotwoWalletState extends State<GotwoWallet> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                        "Wallet",
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
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    //Request
                    children: [
                      TabHistory(),
                    ],
                  ),
                  Column(
                    //Confirm
                    children: [
                      TabPending(),
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
