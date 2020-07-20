import 'package:flutter/widgets.dart';

class CoolStepperConfig {
  /// The text that should be displayed for the back button
  ///
  /// default is 'BACK'
  final String backText;

  /// The text that should be displayed for the next button
  ///
  /// default is 'NEXT'
  final String nextText;

  /// The text that describes the progress
  ///
  /// default is 'STEP'
  final String stepText;

  /// The text that describes the progress
  ///
  /// default is 'OF'
  final String ofText;

  /// This is the background color of the header
  final Color headerColor;

  /// This is the color of the icon
  /// 
  /// [This does not apply when icon is set]
  final Color iconColor;

  /// This icon replaces the default icon
  final Icon icon;

  /// This is the textStyle for the title text
  final TextStyle titleTextStyle;

  /// This is the textStyle for the subtitle text
  final TextStyle subtitleTextStyle;

  

  const CoolStepperConfig({
    this.backText,
    this.nextText,
    this.stepText,
    this.ofText,
    this.headerColor,
    this.iconColor,
    this.icon,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });
}
