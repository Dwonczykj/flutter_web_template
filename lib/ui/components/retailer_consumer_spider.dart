import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:tuple/tuple.dart';

class RetailerConsumerSpiderContainer extends StatefulWidget {
  const RetailerConsumerSpiderContainer({Key? key}) : super(key: key);

  @override
  _RetailerConsumerSpiderContainerState createState() =>
      _RetailerConsumerSpiderContainerState();
}

class _RetailerConsumerSpiderContainerState
    extends State<RetailerConsumerSpiderContainer> {
  List<Widget> _consumers = <Widget>[];

  List<Tuple2<double, double>> getPointsPercentages(
      int numberOfPoints, double childRadius) {
    List<Tuple2<double, double>> points = [];
    for (int i = 0; i < numberOfPoints; i++) {
      childRadius = max(min(1, childRadius), 0);
      numberOfPoints = max(1, numberOfPoints);
      double divisor = numberOfPoints / 2.0;
      double X = i / divisor;
      X *= 4.0; // 1 in [0,4]

      Tuple2<double, double>? point;

      if (0 <= X && X < 1) {
        point = Tuple2(
            1 * (1 - childRadius), (0.5 * (1 - childRadius)) - (X * 0.5));
      } else if (X < 2) {
        X = X - 1.0;
        point = Tuple2((1 * (1 - childRadius)) - (X * 0.5), 0);
      } else if (X < 3) {
        X = X - 2.0;
        point = Tuple2((0.5 * (1 - childRadius)) - (X * 0.5), 0);
      } else if (X < 4) {
        X = X - 3.0;
        point = Tuple2(0, 0 + (X * 0.5));
      } else if (X < 5) {
        X = X - 4.0;
        point = Tuple2(0, (0.5 * (1 - childRadius)) + (X * 0.5));
      } else if (X < 6) {
        X = X - 5.0;
        point = Tuple2(0 + (X * 0.5), 1 * (1 - childRadius));
      } else if (X < 7) {
        X = X - 6.0;
        point = Tuple2(
            (0.5 * (1 - childRadius)) + (X * 0.5), 1 * (1 - childRadius));
      } else if (X < 8) {
        X = X - 7.0;
        point =
            Tuple2(1 * (1 - childRadius), (1 * (1 - childRadius)) - (X * 0.5));
      }
      if (point != null) {
        points.add(point);
      }
    }
    return points;
  }

  Future<String> fetchUserOrder() =>
      // Imagine that this function is
      // more complex and slow.
      Future.delayed(
        const Duration(seconds: 2),
        () => 'Large Latte',
      );

  Future<String> createOrderMessage() async {
    var order = await fetchUserOrder();
    return 'Your order is: $order';
  }

  Future<List<Widget>> consumers(BuildContext context,
      {int numChildren = 1, double childRadius = 0.05}) async {
    double centerX = MediaQuery.of(context).size.width / 2.0;
    double centerY = MediaQuery.of(context).size.height / 2.0;

    var points = getPointsPercentages(numChildren, childRadius);
    const double money_d = 10.0;
    const double rad = money_d / 2.0;

    var divs = points.asMap().entries.map((entry) async {
      var i = entry.key;
      var p = entry.value;
      final String rawSvg = '''<svg class="transaction-line"  
            viewBox="0 0 100 100"
            preserveAspectRatio="none meet"
            >''' +
          '<path d=" M ' +
          ((p.item1 + childRadius * 0.5) * 100.0).toString() +
          ',' +
          ((p.item2 + childRadius * 0.5) * 100.0).toString() +
          ' l ' +
          (50.0 - ((p.item1 + childRadius * 0.5) * 100.0)).toString() +
          ',' +
          (50.0 - ((p.item2 + childRadius * 0.5) * 100.0)).toString() +
          '"' +
          ' stroke="white" stroke-width="0.5" fill="none"/>' +
          '</svg>';

      final SvgParser parser = SvgParser();
      try {
        parser.parse(rawSvg, warningsAsErrors: true);
        // print('SVG is supported');
      } catch (e) {
        print('SVG contains unsupported features');
      }

      DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, rawSvg);

      final picture = svgRoot.toPicture();

      final image = (await picture.toImage(100, 100));

      final rawImage = RawImage(
        image: image,
        width: centerX,
        height: centerY,
      );

      return Positioned(
        top: 0.0,
        left: 0.0,
        right: 0,
        bottom: 0,
        child: Container(
          // color: Colors.red,
          child: rawImage,
        ),
      );

      // return '''<svg class="transaction-line"
      //               width="100%" height="100%"
      //               viewBox="0 0 100 100"
      //               preserveAspectRatio="none meet"
      //               style="position: absolute;
      //               left:0%; top:0%;
      //       ">''' +
      //     '<path d=" M ' +
      //     ((p.item1 + childRadius * 0.5) * 100.0).toString() +
      //     ',' +
      //     ((p.item2 + childRadius * 0.5) * 100.0).toString() +
      //     ' l ' +
      //     (50.0 - ((p.item1 + childRadius * 0.5) * 100.0)).toString() +
      //     ',' +
      //     (50.0 - ((p.item2 + childRadius * 0.5) * 100.0)).toString() +
      //     '"' +
      //     ' stroke="white" stroke-width="0.5" fill="none"/>' +
      //     '''<circle r="1"
      //           cx="''' +
      //     ((p.item1 + childRadius * 0.5) * 100.0).toString() +
      //     '''"
      //           cy="''' +
      //     ((p.item2 + childRadius * 0.5) * 100.0).toString() +
      //     '''"
      //           id="dot''' +
      //     i.toString() +
      //     '''"
      //           style="fill: pink;">
      //           <animateTransform attributeName="transform"
      //               type="translate"
      //               from="0 0"
      //               to="''' +
      //     (50.0 - ((p.item1 + childRadius * 0.5) * 100.0)).toString() +
      //     ' ' +
      //     (50.0 - ((p.item2 + childRadius * 0.5) * 100.0)).toString() +
      //     '''"
      //               begin="0s"
      //               dur="5s"
      //               repeatCount="indefinite">
      //           </animateTransform>
      //       </circle>
      //       <image width="''' +
      //     money_d.toString() +
      //     '''" height="''' +
      //     money_d.toString() +
      //     '''"
      //           xlink:href="assets/noun-money-1636594.svg">
      //           <animateTransform
      //                           attributeName="transform"
      //                           type="translate"
      //                           from="''' +
      //     ((p.item1 + childRadius * 0.5) * 100.0 - rad).toString() +
      //     ' ' +
      //     ((p.item2 + childRadius * 0.5) * 100.0 - rad).toString() +
      //     '''"
      //                           to="''' +
      //     (50 - rad).toString() +
      //     ''' ''' +
      //     (50 - rad).toString() +
      //     '''"
      //                           begin="0s"
      //                           dur="5s"
      //                           repeatCount="indefinite">
      //   </animateTransform>
      // </image>
      //   </svg>''' +
      //     '<div class="consumer" style="position: absolute; left: ' +
      //     (p.item1 * 100.0).toString() +
      //     '%; top: ' +
      //     (p.item2 * 100.0).toString() +
      //     '%">' +
      //     (i + 1).toString() +
      //     '</div>';
    });
    var x = Future.wait(divs.toList());
    // var y = x.then((value) {
    //   setState(() {
    //     _consumers = value;
    //   });
    // });
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: consumers(context, numChildren: 1, childRadius: 0.05),
        builder: (context, consumersSnapshot) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
            color: Colors.blue[600],
            width: 600,
            height: 800,
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: Stack(children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    'images/noun-buildings-4201535.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: SvgPicture.asset('images/noun-person-4574021.svg',
                      height: 70.0,
                      width: 70.0,
                      color: Colors.red,
                      semanticsLabel: 'A consumer'),
                ),
                ...(consumersSnapshot.hasData
                    ? (consumersSnapshot.data as List<Widget>)
                    : <Widget>[
                        const Placeholder(
                          color: Color.fromARGB(255, 224, 178, 250),
                        )
                      ]),
              ]),
            ),
            // child: SvgPicture.string(
            //     '<svg width="100px" height="100px" style="max-height:100%; max-width:100%; border-radius: 25px; background-color: rgba(255, 160, 0, 0.4);"><image xlink:href="images/noun-money-1636594.svg/></svg>'),
          );
        });
  }
}
