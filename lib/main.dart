import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens/screens.dart';
import 'ui_stage2/network/mock_service.dart';
import 'ui_stage2/network/service_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Services
        Provider<ServiceInterface>(
          create: (_) => MockService.create(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Web Starting Kit',
        theme: ThemeData(
          // This is the theme of your application.§
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange,
        ),
        home: const MyHomePage(title: 'SVG Example'),
      ),
    );
  }
}
