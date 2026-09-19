import 'package:flutter/material.dart';

/// Extension on [num] to provide shorthand [SizedBox] for width and height.
extension SizedBoxExtension on num {
  Widget get w => SizedBox(width: toDouble());
  Widget get h => SizedBox(height: toDouble());
}
