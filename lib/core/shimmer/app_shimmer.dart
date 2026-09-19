import 'package:skeletonizer/skeletonizer.dart';
import '../constants/shared_imports.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final bool enable;

  const AppShimmer({super.key, required this.child, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: enable, child: child);
  }
}
