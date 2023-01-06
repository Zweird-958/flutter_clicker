import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:collection';

const Map<String, Map<String, int>> SHOP_ITEMS = {
  "Miner": {"cpc": 10, "cps": 10, "price": 0, "owned": 0},
  "Super Miner": {"cpc": 10, "cps": 10, "price": 0, "owned": 0},
  "Magic Miner": {"cpc": 10, "cps": 10, "price": 0, "owned": 0},
  "Ultra Miner": {"cpc": 10, "cps": 10, "price": 0, "owned": 0},
};
const SHOP_MULTIPLIER = 1.2;
const SHOP_HEADINGS = ["NAME", "CPS", "CPC", "PRICE", "OWNED", ""];

const FIRST_REBIRTH = 1000;
const REBIRTH_PRICE_MULTIPLIER = 2;

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

// class Player with info

class Player {
  int money;
  int rebirth;
  int cpc;
  int cps;
  Map<String, Map<String, int>> items = deepCopy(SHOP_ITEMS);

  Player({
    this.money = 0,
    this.rebirth = 0,
    this.cpc = 1,
    this.cps = 0,
    // this.items = deepCopy(SHOP_ITEMS),
  });
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
  Player player = Player();

  bool shop = false;

  // Map<String, Map<String, int>> shopPlayer = deepCopy(SHOP_ITEMS);

  void increaseMoney() {
    setState(() {
      // state["money"] =
      //     state["money"]! + state["cpc"]! * (state["rebirth"]! + 1);
      player.money += player.cpc * (player.rebirth + 1);
    });
  }

  void clickPerSecond() {
    setState(() {
      player.money += player.cps;
    });
  }

  void reset() {
    setState(() {
      player = Player();
      shop = false;
      // shopPlayer = deepCopy(SHOP_ITEMS);
    });
  }

  void resetWithOutRebirth() {
    final rebirth = player.rebirth;
    reset();
    setState(() {
      player.rebirth = rebirth;
    });
  }

  void increaseRebirth() {
    if (player.money >=
        (player.rebirth > 0
            ? player.rebirth * REBIRTH_PRICE_MULTIPLIER * FIRST_REBIRTH
            : FIRST_REBIRTH)) {
      resetWithOutRebirth();
      setState(() {
        player.rebirth += 1;
      });
    }
  }

  void toggleShop() {
    setState(() {
      shop = !shop;
    });
  }

  double getSizePercentage(percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        player.money += player.cps;
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
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget buyButton(String key) {
    final lastKey = player.items.keys.last;
    var currentItem = player.items[key];
    void buyItem() {
      if (currentItem == null) {
        return;
      }

      setState(() {
        player.money -= currentItem["price"] as int;
        player.cpc += currentItem["cpc"] as int;
        player.cps += currentItem["cps"] as int;
        currentItem["owned"] = currentItem["owned"]! + 1;
        currentItem["price"] =
            (currentItem["price"]! * SHOP_MULTIPLIER).round();
        // currentItem["cpc"] = (currentItem["cpc"]! * SHOP_MULTIPLIER).round();
        // currentItem["cps"] = (currentItem["cps"]! * SHOP_MULTIPLIER).round();
      });
    }

    return TextButton(
        onPressed: buyItem,
        style: TextButton.styleFrom(
            shape: lastKey == key
                ? const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(10.0)),
                  )
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
            backgroundColor: player.money >= currentItem!["price"]!
                ? Colors.green
                : Colors.red,
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
      allCells.add(TableCell(
          child: label == "BUY"
              ? buyButton(labelList[0])
              : Text(
                  label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )));
      // }
    }

    return TableRow(children: allCells);
  }

  Widget shopWidget() {
    List<TableRow> allItems = [];
    allItems.add(rowOfTable(SHOP_HEADINGS));
    player.items.forEach((key, value) => allItems.add(rowOfTable([
          key,
          value["cps"].toString(),
          value["cpc"].toString(),
          value["price"].toString(),
          "x${value["owned"].toString()}",
          "BUY"
        ])));
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Visibility(
        visible: shop,
        // child: SizedBox(
        // width: getSizePercentage(0.7),
        child: Container(
            margin: const EdgeInsets.only(top: 20.0),
            width: constraints.maxWidth * 0.7,
            child: Table(
              // defaultColumnWidth: const FixedColumnWidth(100.0),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                  color: Colors.red,
                  width: 1.0,
                  borderRadius: BorderRadius.circular(10.0)),
              children: allItems,
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top Bar
      appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("CPS : ${player.cps}"),
        // Text("PLAYER : ${player.money}"),
        // Text("STATE : ${state["money"]}"),
        Text("\$${player.money.toString()}"),
        Text("REBIRTH : ${player.rebirth}"),
        Text("CPC : ${player.cpc}"),
      ])),
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
            createButton(
                Colors.purple.shade600,
                "REBIRTH : ${player.rebirth > 0 ? player.rebirth * REBIRTH_PRICE_MULTIPLIER * FIRST_REBIRTH : FIRST_REBIRTH}",
                increaseRebirth)
          ])),
      // Bouton flottant
      // floatingActionButton: FloatingActionButton(
      //   onPressed: increaseMoney,
      //   // Hover button
      //   tooltip: 'Update Text ',
      //   // Contenu du button
      //   child: const Icon(Icons.update),
      // ),
    );
  }
}
