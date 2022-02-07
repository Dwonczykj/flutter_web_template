import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tuple/tuple.dart';

class AnimatedMoneyWidget extends StatefulWidget {
  AnimatedMoneyWidget(
      {Key? key,
      required this.index,
      required this.point,
      required double consumerRadiusPcnt,
      required int numConsumers})
      : super(key: key) {
    this.consumerRadiusPcnt = math.min(1.0, math.max(0.0, consumerRadiusPcnt));
    this.numConsumers = math.max(0, numConsumers);
  }

  final Tuple2<double, double> point;
  final int index;
  late double consumerRadiusPcnt;
  late int numConsumers;

  @override
  _AnimatedMoneyWidgetState createState() => _AnimatedMoneyWidgetState();
}

class _AnimatedMoneyWidgetState extends State<AnimatedMoneyWidget> {
  late List<Tuple2<double, double>> _points;
  int _index = 0;
  List<Alignment> _alignments = [];

  @override
  void initState() {
    super.initState();
    _points = getPointsPercentages(widget.numConsumers);
    _index = widget.index;
    var p1 = Tuple2(
        _getStartPos(widget.point.item1), _getCurPos(widget.point.item2));
    var p2 =
        Tuple2(_getCurPos(widget.point.item1), _getCurPos(widget.point.item2));
    _alignments = [
      Alignment(p1.item1, p1.item2),
      Alignment(p2.item1, p2.item2)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // var p1 = Tuple2(
      //     _getStartPos(widget.point.item1), _getCurPos(widget.point.item2));
      // var p2 = Tuple2(
      //     _getCurPos(widget.point.item1), _getCurPos(widget.point.item2));
      // var _alignments = [
      //   Alignment(p1.item1, p1.item2),
      //   Alignment(p2.item1, p2.item2)
      // ];
      // TODO: Workout how to update the state on this...
      return AnimatedAlign(
        alignment: _alignments[widget.index %
            _alignments
                .length], //if this changes, animation will occur on paint to update.
        duration: Duration(seconds: 6),
        curve: Curves.fastOutSlowIn,
        child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: SvgPicture.asset('images/noun-money-4563489.svg',
                height: widget.consumerRadiusPcnt * constraints.maxHeight,
                width: widget.consumerRadiusPcnt * constraints.maxWidth,
                color: Color.fromARGB(255, 14, 109, 61),
                semanticsLabel: 'A £ Note')),
      );
    });
  }

  double _getStartPos(double posPcnt) {
    return (((posPcnt +
                (widget.consumerRadiusPcnt *
                    0.5)) // Add Half width of consumer icon to take us from 0.0 to centre of consumer as start for the cash animation.
            *
            2.0 -
        1.0));
  }

  double _getCurPos(double posPcnt) {
    return (((posPcnt +
                (widget.consumerRadiusPcnt *
                    0.5)) // Add Half width of consumer icon to take us from 0.0 to centre of consumer as start for the cash animation.
            *
            2.0 -
        1.0));
  }

  List<Tuple2<double, double>> getPointsPercentages(int numberOfPoints) {
    List<Tuple2<double, double>> points = [];
    var range = List<int>.generate(numberOfPoints, (i) => i);
    for (int i in range) {
      var marginInPcnt = math.min(
          1,
          math.max(
              0,
              widget
                  .consumerRadiusPcnt)); //TODO P2: Confirm that we are happy to get %margin from width
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
}
