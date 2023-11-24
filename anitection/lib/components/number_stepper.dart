
import 'package:anitection/components/stroke_text.dart';
import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final int totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  const NumberStepper({
    Key? key,
    required this.width,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        children: _steps(),
      ),
    );
  }

  getCircleColor(i) {
    Color color;
    if (i + 1 <= curStep) {
      color = stepCompleteColor;
    } else {
      color = inactiveColor;
    }
    return color;
  }

  getBorderColor(i) {
    Color color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      color = currentStepColor;
    } else {
      color = inactiveColor;
    }

    return color;
  }

  Color? getLineColor(i) {
    Color? color =
    curStep > i + 1 ? Colors.red.withOpacity(0.4) : Colors.grey[200];
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      Color? lineColor = getLineColor(i);

      // step circles
      list.add(
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: getInnerElementOfStepper(i),
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              decoration: BoxDecoration(
                color: lineColor ?? Colors.grey,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.0,
                    offset: Offset(0, 2),
                  ),
                ],
              )
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfStepper(index) {
    return Center(
      child: StrokeText(
        text: (index + 1).toString(),
        strokeWidth: 4,
        strokeColor: Colors.white,
        textColor: const Color(0xFF573F1B),
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.1
        ),
      ),
    );
  }
}