library cool_stepper;

export 'package:cool_stepper/src/models/cool_step.dart';
export 'package:cool_stepper/src/models/cool_stepper_config.dart';

import 'package:another_flushbar/flushbar.dart';

import 'package:cool_stepper/src/models/cool_step.dart';
import 'package:cool_stepper/src/models/cool_stepper_config.dart';
import 'package:cool_stepper/src/widgets/cool_stepper_view.dart';
import 'package:flutter/material.dart';

/// CoolStepper
class CoolStepper extends StatefulWidget {
  /// The steps of the stepper whose titles, subtitles, content always get shown.
  ///
  /// The length of [steps] must not change.
  final List<CoolStep> steps;

  /// Actions to take when the final stepper is passed
  final VoidCallback onCompleted;

  /// Padding for the content inside the stepper
  final EdgeInsetsGeometry contentPadding;

  /// CoolStepper config
  final CoolStepperConfig config;

  /// This determines if or not a snackbar displays your error message if validation fails
  ///
  /// default is false
  final bool showErrorSnackbar;

  const CoolStepper({
    Key? key,
    required this.steps,
    required this.onCompleted,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0),
    this.config = const CoolStepperConfig(),
    this.showErrorSnackbar = false,
  }) : super(key: key);

  @override
  State<CoolStepper> createState() => _CoolStepperState();
}

class _CoolStepperState extends State<CoolStepper> {
  PageController? _controller = PageController();

  int currentStep = 0;

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  Future<void>? switchToPage(int page) {
    _controller!.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    return null;
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  Future<void> onStepNext() async {
    // final context
    final validation = await widget.steps[currentStep].validation!();

    /// [validation] is null, no validation rule
    if (validation == null) {
      if (!_isLast(currentStep)) {
        setState(() {
          currentStep++;
        });

        if (mounted) FocusScope.of(context).unfocus();

        await switchToPage(currentStep);
      } else {
        widget.onCompleted();
      }
    } else {
      if (!mounted) return;

      /// [showErrorSnackbar] is true, Show error snackbar rule
      if (widget.showErrorSnackbar) {
        final flush = Flushbar(
          message: validation,
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: const EdgeInsets.all(8.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Theme.of(context).primaryColor,
          ),
          duration: const Duration(seconds: 2),
          leftBarIndicatorColor: Theme.of(context).primaryColor,
        );
        await flush.show(context);

        // final snackBar = SnackBar(content: Text(validation));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void onStepBack() {
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
        physics: const NeverScrollableScrollPhysics(),
        children: widget.steps.map((step) {
          return CoolStepperView(
            step: step,
            contentPadding: widget.contentPadding,
            config: widget.config,
          );
        }).toList(),
      ),
    );

    final counter = Text(
      "${widget.config.stepText ?? 'STEP'} ${currentStep + 1} ${widget.config.ofText ?? 'OF'} ${widget.steps.length}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );

    String getNextLabel() {
      String nextLabel;
      if (_isLast(currentStep)) {
        nextLabel = widget.config.finalText ?? 'FINISH';
      } else {
        if (widget.config.nextTextList != null) {
          nextLabel = widget.config.nextTextList![currentStep];
        } else {
          nextLabel = widget.config.nextText ?? 'NEXT';
        }
      }
      return nextLabel;
    }

    String getPrevLabel() {
      String backLabel;
      if (_isFirst(currentStep)) {
        backLabel = '';
      } else {
        if (widget.config.backTextList != null) {
          backLabel = widget.config.backTextList![currentStep - 1];
        } else {
          backLabel = widget.config.backText ?? 'PREV';
        }
      }
      return backLabel;
    }

    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          onPressed: onStepBack,
          child: Text(
            getPrevLabel(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        counter,
        TextButton(
          onPressed: widget.config.isNextButtonLoading ? null : onStepNext,
          child: widget.config.isNextButtonLoading
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  )
                : Text(
            getNextLabel(),
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    );

    return Column(
      children: [content, buttons],
    );
  }
}
