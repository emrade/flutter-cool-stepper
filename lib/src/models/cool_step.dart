import 'package:flutter/widgets.dart';

class CoolStep {
  final String title;
  final String subtitle;
  final Widget content;
  final String? Function()? validation;
  final bool isHeaderEnabled;
  final EdgeInsetsGeometry headerMargin;
  final EdgeInsetsGeometry headerPadding;

  CoolStep({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.validation,
    this.isHeaderEnabled = true,
    this.headerMargin = const EdgeInsets.only(bottom: 20.0),
    this.headerPadding = const EdgeInsets.all(20.0),
  });
}
