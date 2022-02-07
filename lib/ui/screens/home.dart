import 'package:flutter/material.dart';
import 'package:webtemplate/ui/screens/screens.dart';
import '../components/path_example.dart';
// import 'package:webtemplate/ui/components/retailer_consumer_spider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumers(numConsumers: 8);
    // return SpiderLayout();
  }
}
