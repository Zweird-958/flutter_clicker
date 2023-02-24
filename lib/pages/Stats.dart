import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Stats extends StatefulWidget {
  Map<String, int> state;
  Stats({super.key, required this.state});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> state = widget.state;
    List<String> keys = state.keys.toList();
    List<int> values = state.values.toList();

    return Center(
      child: ListView.builder(
        itemCount: state.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blue.shade300)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(keys[index].toUpperCase()),
                Text("${values[index]}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
