import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool enable;
  const LoadingOverlay({super.key,required this.enable});

  @override
  Widget build(BuildContext context) {
    return 
    !enable?const SizedBox.shrink(): 
    const Positioned.fill(
      child: AbsorbPointer(child: ColoredBox(color: Colors.black12)),
    );
  }
}
