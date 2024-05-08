import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = [
    'images/bill.png',
    'images/bill.png',
    'images/bill.png',
    'images/bill.png',
    'images/bill.png',
    'images/bill.png',
    'images/bill.png',
    'images/bill.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accounting App",
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 30,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Image.asset(
            items[index],
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
