import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("CLICKER"),
          ),
        ),
        body: const Center(
          child: Text("HELLO"),
        ),
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
