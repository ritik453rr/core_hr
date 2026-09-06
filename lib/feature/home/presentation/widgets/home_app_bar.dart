import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/home_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapProfile;
  final VoidCallback? onTapNotifications;

  const HomeAppBar({
    super.key,
    this.onTapProfile,
    this.onTapNotifications,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return AppBar(
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
      toolbarHeight: 70,
      title: InkWell(
        onTap: onTapProfile ?? controller.onTapProfile,
        borderRadius: BorderRadius.circular(12),
        child: GetBuilder<HomeController>(
          id: HomeBuilderIds.userProfile,
          builder: (ctrl) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppNetworkImage(
                imgUrl: ctrl.profileImageUrl,
                width: 42,
                height: 42,
                borderRadius: 12,
                placeholder: (context, url) => Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      ctrl.employeeInitials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      ctrl.employeeInitials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ctrl.employeeName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ctrl.employeeSubtitle,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 26,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: onTapNotifications ?? controller.onTapNotifications,
          tooltip: StringConstants.kNotifications,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
