import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: SvgPicture.asset(
        'images/noun-buildings-4201535.svg',
        height: 100,
        width: 100,
      ),
      // child: SvgPicture.string(
      //     '<svg width="100px" height="100px" style="max-height:100%; max-width:100%; border-radius: 25px; background-color: rgba(255, 160, 0, 0.4);"><image xlink:href="assets/images/noun-money-1636594.svg/></svg>'),
    );
  }
}
