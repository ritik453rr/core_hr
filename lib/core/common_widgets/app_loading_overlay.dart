import 'package:flutter/material.dart';

class AppLoadingOverlay extends StatelessWidget {
  final bool enable;
  const AppLoadingOverlay({super.key, required this.enable});

  @override
  Widget build(BuildContext context) {
    if (!enable) return const SizedBox.shrink();

    return const AbsorbPointer(
      child: SizedBox.expand(
        child: ColoredBox(color: Colors.black12),
      ),
    );
  }
}
