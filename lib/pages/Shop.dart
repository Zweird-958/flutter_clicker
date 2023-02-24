import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Shop extends StatefulWidget {
  List<Map<String, dynamic>> items;
  Function buyItem;
  int money;
  Shop({
    super.key,
    required this.items,
    required this.buyItem,
    required this.money,
  });

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  // ignore: non_constant_identifier_names
  Widget TextWithPadding(label) => Padding(
        padding: const EdgeInsets.only(left: 2.5, right: 2.5),
        child: Text(label),
      );

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = widget.items;

    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final title = item["title"];
          int price = item["price"];

          return ListTile(
            title: Text("$title"),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithPadding("Price : $price\$"),
                TextWithPadding("CPC : ${item["cpc"]}"),
                TextWithPadding("CPS : ${item["cps"]}"),
                TextWithPadding("Owned : x${item["owned"]}"),
              ],
            ),
            trailing: IconButton(
              onPressed: widget.buyItem(index),
              icon: Icon(
                Icons.monetization_on,
                color: widget.money < price ? Colors.red : Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}
