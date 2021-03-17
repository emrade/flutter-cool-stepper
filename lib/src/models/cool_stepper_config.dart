import 'package:flutter/widgets.dart';

class CoolStepperConfig {
  /// The widget that should be displayed for the back button
  ///
  /// default is an OutlinedButton
  final Widget backBtn;

  /// The widget that should be displayed for the next button
  ///
  /// default is an OutlinedButton
  final Widget nextBtn;

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

  /// This flag can disable the header
  final bool hasHeader;

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

  /// A List of string that when supplied will override 'backText'
  ///
  /// Must be one less than the number of steps since for the first step, the backText won't be visible
  final List<String> backTextList;

  /// A List of string that when supplied will override 'nextText'
  ///
  /// Must be one less than the number of steps since the 'finalText' attribute is able to set the value for the final step's next button
  final List<String> nextTextList;

  /// The widget that should be displayed for the next button on the final step
  ///
  /// default is an OutlinedButton
  final Widget finalBtn;

  const CoolStepperConfig({
    this.backBtn,
    this.nextBtn,
    this.stepText,
    this.ofText,
    this.headerColor,
    this.hasHeader = false,
    this.iconColor,
    this.icon,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.backTextList,
    this.nextTextList,
    this.finalBtn,
  });
}
