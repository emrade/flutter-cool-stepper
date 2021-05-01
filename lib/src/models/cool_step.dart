import 'package:flutter/widgets.dart';

class CoolStep {
  final String title;
  final String subtitle;
  final Widget content;
  final String? Function()? validation;
  final bool isHeaderEnabled;

  CoolStep({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.validation,
    this.isHeaderEnabled = true
  });
}
