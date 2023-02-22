import 'package:flutter/material.dart';
import 'package:flutter_clicker_2/pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int money = 0;

  increaseMoney() {
    setState(() {
      money += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("CLICKER"),
          ),
        ),
        body: Home(money: money, increaseMoney: increaseMoney),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "SHOP",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "STATS",
            ),
          ],
        ),
      ),
    );
  }
}
