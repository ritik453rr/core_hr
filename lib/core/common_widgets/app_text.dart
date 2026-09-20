import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A reusable text widget that automatically translates the provided text.
class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const AppText(this.data, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(data.tr, style: style);
  }
}
