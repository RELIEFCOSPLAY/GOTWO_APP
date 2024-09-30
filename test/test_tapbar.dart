import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestTapbar extends StatefulWidget {
  const TestTapbar({super.key});

  @override
  State<TestTapbar> createState() => _TestTapbarState();
}

class _TestTapbarState extends State<TestTapbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test Tapbar"),
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Color(0xff1a1c43),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Color(0xff1a1c43),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Color(0xff1a1c43),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Color(0xff1a1c43),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Color(0xff1a1c43),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: const Center(
                      child: Text("Tabbar1"),
                    ),
                  ),
                  Container(
                    child: const Center(
                      child: Text("Tabbar2"),
                    ),
                  ),
                  Container(
                    child: const Center(
                      child: Text("Tabbar3"),
                    ),
                  ),
                  Container(
                    child: const Center(
                      child: Text("Tabbar4"),
                    ),
                  ),
                  Container(
                    child: const Center(
                      child: Text("Tabbar5"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
