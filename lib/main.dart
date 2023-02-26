import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clicker_2/pages/Calendar.dart';
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
    {'title': 'Drill', 'price': 50, 'cpc': 5, 'cps': 1, 'owned': 0},
    {'title': 'Excavator', 'price': 100, 'cpc': 10, 'cps': 2, 'owned': 0},
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        state = {
          ...state,
          "money": state["money"]! + state["cpc"]! * state["cps"]!
        };
      });
    });
  }

  increaseMoney() {
    setState(() {
      state = {...state, "money": state["money"]! + state["cpc"]!};
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

  BottomNavigationBarItem AnimatedNavItem(
          IconData icon, String label, int index) =>
      BottomNavigationBarItem(
        icon: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? Colors.blue.shade100
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(icon),
        ),
        label: label,
      );

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
          Stats(state: state),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: handleNav,
          items: [
            AnimatedNavItem(Icons.home, "HOME", 0),
            AnimatedNavItem(Icons.shopping_cart, "SHOP", 1),
            AnimatedNavItem(Icons.account_circle, "STATS", 2),
          ],
        ),
      ),
    );
  }
}
