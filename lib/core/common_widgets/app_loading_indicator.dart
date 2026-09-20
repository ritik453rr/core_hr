import 'package:flutter/cupertino.dart';

/// A customizable circular loading indicator.
class AppLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double radius;

  const AppLoadingIndicator({super.key, this.color, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(color: color, radius: radius);
  }
}
