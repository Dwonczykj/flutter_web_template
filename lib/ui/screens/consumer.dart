import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuple/tuple.dart';
import 'package:webtemplate/ui/components/animated_money_widget.dart';

class Consumers extends StatefulWidget {
  const Consumers({Key? key, required this.numConsumers}) : super(key: key);

  final int numConsumers;

  @override
  _ConsumersState createState() => _ConsumersState();
}

class _ConsumersState extends State<Consumers>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Tuple2<double, double>> _points;

  bool showDots = false, showPath = true;

  double consumerRadiusPcnt = 0.05;

  int numConsumers = 1;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.value = 1.0;
    numConsumers = widget.numConsumers;
    _points = getPointsPercentages(widget.numConsumers);
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green point flow'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Center(
                      child: Stack(fit: StackFit.expand, children: <Widget>[
                        // CustomPaint(
                        //   painter: ConsumerPainter(
                        //     consumerRadiusPcnt,
                        //     _points,
                        //     numConsumers: numConsumers.toDouble(),
                        //     moneyProgress: _controller.value,
                        //     showDots:
                        //         showDots, //TODO P2: Remove properties if not used
                        //     showPath:
                        //         showPath, //TODO P2: Remove properties if not used
                        //   ),
                        // ),
                  ...createConsumerSVGAtPosition().toList(),
                  // ...createMoneySVGAtPosition(_index).toList(),
                  ..._points.map((point) => AnimatedMoneyWidget(
                      index: _index,
                      point: point,
                      consumerRadiusPcnt: consumerRadiusPcnt,
                      numConsumers: numConsumers))
                      ]),
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24.0, right: 0.0),
            //       child: Text('Show Dots'),
            //     ),
            //     Switch(
            //       value: showDots,
            //       onChanged: (value) {
            //         setState(() {
            //           showDots = value;
            //         });
            //       },
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 24.0, right: 0.0),
            //       child: Text('Show Path'),
            //     ),
            //     Switch(
            //       value: showPath,
            //       onChanged: (value) {
            //         setState(() {
            //           showPath = value;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 24.0),
            //   child: Text('Circles'),
            // ),
            // Slider(
            //   value: numConsumers.toDouble(),
            //   min: 1.0,
            //   max: 10.0,
            //   divisions: 9,
            //   label: numConsumers.toInt().toString(),
            //   onChanged: (value) {
            //     setState(() {
            //       numConsumers = value.toInt();
            //     });
            //   },
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 24.0),
            //   child: Text('Progress'),
            // ),
            // Slider(
            //   value: _controller.value,
            //   min: 0.0,
            //   max: 1.0,
            //   onChanged: (value) {
            //     setState(() {
            //       _controller.value = value;
            //     });
            //   },
            // ),
            Center(
              child: RaisedButton(
                child: Text('Animate'),
                onPressed: () {
                  // _controller.reset();
                  // _controller.forward();
                  setState(() {
                    _index++; //NOTE: Thie changes the value of the _alignment getter which tells the widget to animate itself.
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Tuple2<double, double>> getPointsPercentages(int numberOfPoints) {
    List<Tuple2<double, double>> points = [];
    var range = List<int>.generate(numberOfPoints, (i) => i);
    for (int i in range) {
      var marginInPcnt = math.min(
          1,
          math.max(0,
              consumerRadiusPcnt)); //TODO P2: Confirm that we are happy to get %margin from width
      numberOfPoints = math.max(1, numberOfPoints);
      double divisor = numberOfPoints.toDouble() / 2.0;
      double X = i.toDouble() / divisor;
      X *= 4.0; // 1 in [0,4]

      Tuple2<double, double>? point;

      if (0.0 <= X && X < 1) {
        point = Tuple2(1.0 * (1.0 - marginInPcnt),
            (0.5 * (1.0 - marginInPcnt)) - (X * 0.5));
      } else if (X < 2) {
        X = X - 1.0;
        point = Tuple2((1.0 * (1.0 - marginInPcnt)) - (X * 0.5), 0);
      } else if (X < 3) {
        X = X - 2.0;
        point = Tuple2((0.5 * (1.0 - marginInPcnt)) - (X * 0.5), 0);
      } else if (X < 4) {
        X = X - 3.0;
        point = Tuple2(0, 0.0 + (X * 0.5));
      } else if (X < 5) {
        X = X - 4.0;
        point = Tuple2(0, (0.5 * (1.0 - marginInPcnt)) + (X * 0.5));
      } else if (X < 6) {
        X = X - 5.0;
        point = Tuple2(0.0 + (X * 0.5), 1.0 * (1.0 - marginInPcnt));
      } else if (X < 7) {
        X = X - 6.0;
        point = Tuple2((0.5 * (1.0 - marginInPcnt)) + (X * 0.5),
            1.0 * (1.0 - marginInPcnt));
      } else if (X < 8) {
        X = X - 7.0;
        point = Tuple2(1.0 * (1.0 - marginInPcnt),
            (1.0 * (1.0 - marginInPcnt)) - (X * 0.5));
      }
      if (point != null) {
        points.add(point);
      }
    }
    return points;
  }

  Iterable<Widget> createMoneySVGAtPosition(int index) {
    double Function(double) getStartPos = (double posPcnt) => (((posPcnt +
                (consumerRadiusPcnt *
                    0.5)) // Add Half width of consumer icon to take us from 0.0 to centre of consumer as start for the cash animation.
            *
            2.0 -
        1.0));
    double Function(double) getCurPos = (double posPcnt) => (((posPcnt +
                (consumerRadiusPcnt *
                    0.5)) // Add Half width of consumer icon to take us from 0.0 to centre of consumer as start for the cash animation.
            *
            2.0 -
        1.0));

    

    return _points.map((pr) => LayoutBuilder(builder: (context, constraints) {
          var p1 = Tuple2(getStartPos(pr.item1), getCurPos(pr.item2));
          var p2 = Tuple2(getCurPos(pr.item1), getCurPos(pr.item2));
          var _alignments = [
            Alignment(p1.item1, p1.item2),
            Alignment(p2.item1, p2.item2)
          ];
          return AnimatedAlign(
            alignment: _alignments[index %
                _alignments
                    .length], //if this changes, animation will occur on paint to update.
            duration: Duration(seconds: 6),
            curve: Curves.fastOutSlowIn,
            child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: SvgPicture.asset('images/noun-money-4563489.svg',
                    height: consumerRadiusPcnt * constraints.maxHeight,
                    width: consumerRadiusPcnt * constraints.maxWidth,
                    color: Color.fromARGB(255, 14, 109, 61),
                    semanticsLabel: 'A £ Note')),
          );
        }));
  }

  Iterable<Widget> createConsumerSVGAtPosition() {
    double Function(double) getCurPos = (double posPcnt) => (((posPcnt +
                (consumerRadiusPcnt *
                    0.5)) // Add Half width of consumer icon to take us from 0.0 to centre of consumer as start for the cash animation.
            *
            2.0 -
        1.0));
    return _points.map((pr) => LayoutBuilder(builder: (context, constraints) {
          var p = Tuple2(getCurPos(pr.item1), getCurPos(pr.item2));
          return Positioned.fill(
              child: Align(
                  alignment: Alignment(p.item1, p.item2),
                  child: SvgPicture.asset('images/noun-person-4574021.svg',
                      height: consumerRadiusPcnt * constraints.maxHeight,
                      width: consumerRadiusPcnt * constraints.maxWidth,
                      color: Color.fromARGB(255, 45, 46, 46),
                      semanticsLabel: 'A consumer')));
        }));
  }
}

class ConsumerPainter extends CustomPainter {
  ConsumerPainter(this.consumerRadius, this.pointPercentages,
      {this.numConsumers = 1.0,
      this.moneyProgress = 0.5,
      this.showDots = true,
      this.showPath = true});

  final double numConsumers, moneyProgress;
  bool showDots, showPath;

  var myPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0;

  final double consumerRadius;
  final List<Tuple2<double, double>> pointPercentages;

  @override
  void paint(Canvas canvas, Size size) {
    /*TODO P1: Wrap the Canvas in a stack that we can place the positioned Widgets on, 
      as we dont need to paint them, just to use teh animation builder to position them. 
      Then draw the line paths onto the canvas as poc*/
    var path = createLinesToCentre(size);
    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * moneyProgress,
      );
      if (showPath) {
        canvas.drawPath(extractPath, myPaint);
      }
      if (showDots) {
        try {
          var metric = extractPath.computeMetrics().first;
          final offset = metric.getTangentForOffset(metric.length)!.position;
          canvas.drawCircle(offset, 8.0, Paint());
        } catch (e) {}
      }
    }
  }

  Path createLinesToCentre(Size size) {
    var path = Path();
    int n = numConsumers.toInt();

    var points = pointPercentages;

    points.forEach((p) {
      // TODO P4: Refactor this logic into a private method or nested function.
      var startPosX = ((p.item1 + consumerRadius * 0.5) * size.width);
      var startPosY = ((p.item2 + consumerRadius * 0.5) * size.height);
      var curPosX = (50.0 - ((p.item1 + consumerRadius * 0.5) * size.width));
      var curPosY = (50.0 - ((p.item2 + consumerRadius * 0.5) * size.height));

      var subPath = Path();
      subPath.moveTo(startPosX, startPosY);
      subPath.lineTo(curPosX, curPosY);
      path.addPath(subPath, Offset(0, 0));
    });

    return path;
  }

  @override
  bool shouldRepaint(ConsumerPainter oldDelegate) {
    return numConsumers != oldDelegate.numConsumers ||
        moneyProgress != oldDelegate.moneyProgress ||
        showDots != oldDelegate.showDots ||
        showPath != oldDelegate.showPath;
  }
}
