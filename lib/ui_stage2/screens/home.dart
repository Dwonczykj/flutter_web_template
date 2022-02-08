import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webtemplate/ui/screens/screens.dart';
import 'package:webtemplate/ui_stage2/network/service_interface.dart';
import '../components/path_example.dart';
import '../network/mock_service.dart';
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
    return Consumer<ServiceInterface>(builder: (context, service, child) {
      return FutureBuilder(
          future: service.queryService('Dummy'),
          initialData: <ConsumerObj>[],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumers(numConsumers: (snapshot.data as List).length);
            } else {
              return Consumers(numConsumers: 8);
            }
          });
    });
    // return AnimatedAlignDemo();
  }
}
