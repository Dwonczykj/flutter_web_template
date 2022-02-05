import 'package:flutter/material.dart';

class RetailerConsumerSpiderContainer extends StatefulWidget {
  const RetailerConsumerSpiderContainer({Key? key}) : super(key: key);

  @override
  _RetailerConsumerSpiderContainerState createState() =>
      _RetailerConsumerSpiderContainerState();
}

class _RetailerConsumerSpiderContainerState
    extends State<RetailerConsumerSpiderContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
      color: Colors.blue[600],
      width: 400,
      height: 800,
      alignment: Alignment.center,
      child: const Image(
        height: 300.0,
        image: AssetImage('assets/images/noun-buildings-4201535.svg'),
      ),
    );
  }
}
