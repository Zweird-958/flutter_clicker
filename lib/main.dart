import 'package:flutter/material.dart';

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

  void increaseMoney() {
    setState(() {
      // state["money"]? += 5;
      money++;
    });
  }

  void reset() {
    setState(() {
      money = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top Bar
      appBar: AppBar(
        title: Center(child: Text(money.toString())),
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
                createButton(Colors.green.shade600, "SHOP", increaseMoney),
                createButton(Colors.red.shade600, "RESET", reset)
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
