import 'package:flutter/material.dart';

class Labtest2 extends StatefulWidget {
  const Labtest2({super.key});

  @override
  State<Labtest2> createState() => _Labtest2State();
}

class _Labtest2State extends State<Labtest2> {
  final List<String> myList = [
    'Go',
    'lo',
    'ศ.อ',
    'pop',
    'xxx',
  ];

  List products = [
    {'name': 'hat', 'price': 180},
    {'name': 'bag', 'price': 300},
    {'name': 'sock', 'price': 50},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LabTsrt2'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                // ListTile(
                //   leading: ElevatedButton(
                //       onPressed: () {}, child: Text(myList[index])),
                // ),
                // ElevatedButton(onPressed: () {}, child: Text(products[index])),
                Text("Due: ${products[index]['price']}"),
              ],
            );
          },
        ),
      ),
    );
  }
}
