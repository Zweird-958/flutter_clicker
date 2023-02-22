import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final items = [
    {'title': 'Miner', 'price': 10, 'cpc': 1, 'cps': 0, 'owned': 0},
    {'title': 'Miner', 'price': 10, 'cpc': 1, 'cps': 0, 'owned': 0},
    {'title': 'Miner', 'price': 10, 'cpc': 1, 'cps': 0, 'owned': 0},
  ];

  // RECUPERER LITEM CORRESPOND GRACE A LINDEX

  Widget TextWithPadding(label) => Padding(
        padding: EdgeInsets.only(left: 2.5, right: 2.5),
        child: Text(label),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final title = item["title"];

          return ListTile(
            title: Text("$title"),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithPadding("Price : ${item["price"]}\$"),
                TextWithPadding("CPC : ${item["cpc"]}"),
                TextWithPadding("CPS : ${item["cps"]}"),
                TextWithPadding("Owned : x${item["owned"]}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
