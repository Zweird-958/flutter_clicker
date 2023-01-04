import 'dart:async';

import 'package:flutter/material.dart';

const shopItems = {
  "Miner": {"cpc": 10, "cps": 10, "price": 10, "owned": 0}
};

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // var state = {
  //   "money": 100,
  //   "cpc": 0.1
  // };

  int money = 0;
  int cpc = 1;
  int cps = 0;
  bool shop = false;

  var shopPlayer = Map.from(shopItems);

  void increaseMoney() {
    setState(() {
      money += cpc;
    });
  }

  void reset() {
    setState(() {
      money = 0;
      shop = false;
      cpc = 1;
      cps = 0;
      shopPlayer = Map.from(shopItems);
    });
  }

  void toggleShop() {
    setState(() {
      shop = !shop;
    });
  }

  Widget createButton(Color bgColor, String label, function) {
    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: TextButton(
          onPressed: function,
          style: TextButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: Colors.white,
              fixedSize: Size(130, 50),
              // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          child: Text(label),
        ));
  }

  Widget buyButton(String key) {
    var currentItem = shopPlayer[key];
    void buyItem() {
      if (money < currentItem["price"]) {
        return;
      }
      setState(() {
        money -= currentItem["price"] as int;
        cpc += currentItem["cpc"] as int;
        cps += currentItem["cps"] as int;
        currentItem["owned"] += 1;
      });
    }

    return TextButton(
        onPressed: buyItem,
        style: TextButton.styleFrom(
            backgroundColor:
                money >= currentItem["price"] ? Colors.green : Colors.red,
            foregroundColor: Colors.white,
            // fixedSize: Size(130, 50),
            // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        child: const Text("BUY"));
  }

  TableRow rowOfTable(List<String> labelList) {
    List<Widget> allCells = [];
    for (String label in labelList) {
      if (label == "BUY") {
        allCells.add(buyButton(labelList[0]));
      } else {
        allCells.add(TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Center(child: Text(label))));
      }
    }

    return TableRow(children: allCells);
  }

  Widget shopWidget() {
    List<TableRow> allItems = [];
    allItems.add(rowOfTable(["NAME", "CPS", "CPC", "PRICE", "OWNED", ""]));
    shopPlayer.forEach((key, value) => allItems.add(rowOfTable([
          key,
          value["cps"].toString(),
          value["cpc"].toString(),
          value["price"].toString(),
          "x${value["owned"].toString()}",
          "BUY"
        ])));
    return Visibility(
      visible: shop,
      child: SizedBox(
        width: 600.0,
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(100.0),
          border: TableBorder.all(color: Colors.red, width: 1.0),
          children: allItems,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top Bar
      appBar: AppBar(
        title: Center(child: Text("${money.toString()} - ${shop}")),
      ),
      // Contenu de la page
      body: Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                createButton(Colors.blue.shade600, "WORK", increaseMoney),
                shopWidget(),
                createButton(Colors.green.shade600, "SHOP", toggleShop),
                createButton(Colors.red.shade600, "RESET", reset),
              ]))),
      // Bouton flottant
      floatingActionButton: FloatingActionButton(
        onPressed: increaseMoney,
        // Hover button
        tooltip: 'Update Text ',
        // Contenu du button
        child: const Icon(Icons.update),
      ),
    );
  }
}
