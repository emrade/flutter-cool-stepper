library cool_stepper;

export 'package:cool_stepper/src/models/cool_step.dart';

import 'package:cool_stepper/src/models/cool_step.dart';
import 'package:cool_stepper/src/widgets/cool_stepper_view.dart';
import 'package:flutter/material.dart';

/// CoolStepper
class CoolStepper extends StatefulWidget {
  final List<CoolStep> steps;
  final VoidCallback onCompleted;
  final EdgeInsetsGeometry contentPadding;

  const CoolStepper({
    Key key,
    @required this.steps,
    @required this.onCompleted,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0),
  }) : super(key: key);

  @override
  _CoolStepperState createState() => _CoolStepperState();
}

class _CoolStepperState extends State<CoolStepper> {
  PageController _controller = PageController();

  int currentStep = 0;

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  switchToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  onStepNext() {
    String validation = widget.steps[currentStep].validation();
    if (validation == null) {
      if (!_isLast(currentStep)) {
        setState(() {
          currentStep++;
        });
        FocusScope.of(context).unfocus();
        switchToPage(currentStep);
      } else {
        widget.onCompleted();
      }
    } else {
      // Do Nothing
    } 
  }

  onStepBack() {
    if (!_isFirst(currentStep)) {
      setState(() {
        currentStep--;
      });
      switchToPage(currentStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Expanded(
      child: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: widget.steps.map((step) {
          return CoolStepperView(
            step: step,
            contentPadding: widget.contentPadding,
          );
        }).toList(),
      ),
    );

    final counter = Container(
      child: Text(
        "STEP ${currentStep + 1} OF ${widget.steps.length}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final buttons = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: onStepBack,
            child: Text(
              "BACK",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          counter,
          FlatButton(
            onPressed: onStepNext,
            child: Text(
              "NEXT",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      child: Column(
        children: [content, buttons],
      ),
    );
  }
}
