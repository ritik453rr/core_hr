import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/feature/profile/presentation/controller/profile_controller.dart';

/// Custom app bar for the Home screen featuring user profile and notifications.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapProfile;

  const HomeAppBar({super.key, this.onTapProfile});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
      toolbarHeight: 70,
      title: InkWell(
        onTap: onTapProfile,
        borderRadius: BorderRadius.circular(12),
        child: GetBuilder<ProfileController>(
          id: ProfileController.profileId,
          builder: (profileCtrl) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppNetworkImage(
                imgUrl: profileCtrl.profileImageUrl,
                width: 42,
                height: 42,
                borderRadius: 12,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileCtrl.employeeName,
                    style: AppTextStyle.bold16.copyWith(color: Colors.white),
                  ),
                  Text(
                    profileCtrl.employeeSubtitle,
                    style: AppTextStyle.regular11White60.copyWith(
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
