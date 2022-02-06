import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const <Widget>[
          //     ,
          //   ],
          // ),
          child: Container(
        height: 400,
        width: 400,
        color: Colors.grey,
        margin: EdgeInsets.all(5.0),
        child: PathExample(),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
