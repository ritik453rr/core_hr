import 'package:core_hr/core/common_widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';

/// Displays a blocking loading overlay with an optional centered loader.
class AppLoadingOverlay extends StatelessWidget {
  final bool enable;
  final bool showLoader;

  const AppLoadingOverlay({
    super.key,
    required this.enable,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) return const SizedBox.shrink();

    return AbsorbPointer(
      child: SizedBox.expand(
        child: ColoredBox(
          color: Colors.black12,
          child: !showLoader
              ? null
              : const Center(child: AppLoadingIndicator(radius: 14)),
        ),
      ),
    );
  }
}
