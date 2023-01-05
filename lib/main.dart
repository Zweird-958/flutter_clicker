import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:collection';

const Map<String, Map<String, int>> SHOP_ITEMS = {
  "Miner": {"cpc": 10, "cps": 10, "price": 0, "owned": 0}
};

deepCopy(Map<String, Map<String, int>> original) {
  Map<String, Map<String, int>> copy = {};
  original.forEach((key, value) {
    copy[key] = Map.from(value);
  });
  return copy;
}

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

  Map<String, Map<String, int>> shopPlayer = deepCopy(SHOP_ITEMS);

  void increaseMoney() {
    setState(() {
      money += cpc;
    });
  }

  void clickPerSecond() {
    setState(() {
      money += cps;
    });
  }

  void reset() {
    setState(() {
      money = 0;
      shop = false;
      cpc = 1;
      cps = 0;
      shopPlayer = deepCopy(SHOP_ITEMS);
    });
  }

  void toggleShop() {
    setState(() {
      shop = !shop;
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        money += cps;
      });
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
              fixedSize: const Size(130, 50),
              // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          child: Text(label),
        ));
  }

  Widget buyButton(String key) {
    var currentItem = shopPlayer[key];
    void buyItem() {
      if (currentItem == null) {
        return;
      }

      if (currentItem["price"] == null) {
        return;
      }

      setState(() {
        money -= currentItem["price"] as int;
        cpc += currentItem["cpc"] as int;
        cps += currentItem["cps"] as int;
        currentItem["owned"] = currentItem["owned"]! + 1;
      });
    }

    return TextButton(
        onPressed: buyItem,
        style: TextButton.styleFrom(
            backgroundColor:
                money >= currentItem!["price"]! ? Colors.green : Colors.red,
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
        title: Center(
            child: Text("CPS : $cps - \$${money.toString()} - CPC : $cpc")),
      ),
      // Contenu de la page
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            createButton(Colors.blue.shade600, "WORK", increaseMoney),
            shopWidget(),
            createButton(Colors.green.shade600, "SHOP", toggleShop),
            createButton(Colors.red.shade600, "RESET", reset),
          ])),
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
