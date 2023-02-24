import 'package:flutter/material.dart';
import 'package:flutter_clicker_2/pages/Home.dart';
import 'package:flutter_clicker_2/pages/Shop.dart';
import 'package:flutter_clicker_2/pages/Stats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, int> state = {
    "money": 0,
    "cpc": 1,
    "cps": 0,
  };
  int _currentIndex = 0;
  List<Map<String, dynamic>> items = [
    {'title': 'Miner', 'price': 10, 'cpc': 1, 'cps': 0, 'owned': 0},
    {'title': 'Drill', 'price': 50, 'cpc': 1, 'cps': 0, 'owned': 0},
    {'title': 'Excavator', 'price': 100, 'cpc': 1, 'cps': 0, 'owned': 0},
  ];

  increaseMoney() {
    setState(() {
      state = {...state, "money": state["money"]! + state["cpc"]!};
      // money += 1;
    });
  }

  void Function() buyItem(int id) => () {
        Map<String, dynamic> currentItem = items[id];
        if (currentItem["price"] <= state["money"]) {
          Map<String, dynamic> updatedValue = {
            ...currentItem,
            "price": (currentItem["price"] * 1.1).round(),
            "owned": currentItem["owned"] + 1
          };
          int price = currentItem["price"];
          int cpc = currentItem["cpc"];
          int cps = currentItem["cps"];

          setState(() {
            state = {
              ...state,
              "cpc": state["cpc"]! + cpc,
              "cps": state["cps"]! + cps,
              "money": state["money"]! - price
            };
            items = items
                .map((item) => item == currentItem ? updatedValue : item)
                .toList();
          });
        }
      };

  handleNav(index) {
    setState(() {
      _currentIndex = index;
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
        body: [
          Home(money: state["money"], increaseMoney: increaseMoney),
          Shop(
            items: items,
            buyItem: buyItem,
            money: state["money"]!,
          ),
          const Stats(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: handleNav,
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
