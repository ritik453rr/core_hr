import 'package:core_hr/core/constants/shared_imports.dart';

/// Grid of available HR and field services for quick access.
class ServicesGrid extends StatelessWidget {
  final Function(String) onTapService;

  const ServicesGrid({
    super.key,
    required this.onTapService,
  });

  @override
  Widget build(BuildContext context) {
    const services = [
      _ServiceItem(
        title: StringConstants.kHolidays,
        icon: Icons.event_available_rounded,
        color: AppColors.c4F46E5,
      ),
      _ServiceItem(
        title: StringConstants.kApplyLeave,
        icon: Icons.time_to_leave_rounded,
        color: AppColors.c10B981,
      ),
      _ServiceItem(
        title: StringConstants.kApplyForLoan,
        icon: Icons.account_balance_rounded,
        color: AppColors.cD97706,
      ),
      _ServiceItem(
        title: StringConstants.kLeadManagement,
        icon: Icons.business_center_rounded,
        color: AppColors.cEA580C,
      ),
      _ServiceItem(
        title: StringConstants.kHrDocuments,
        icon: Icons.folder_shared_rounded,
        color: AppColors.cDC2626,
      ),
      _ServiceItem(
        title: StringConstants.kOkrAndGoals,
        icon: Icons.emoji_events_rounded,
        color: AppColors.c7C3AED,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final item = services[index];
        return InkWell(
          onTap: () => onTapService(item.title),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cE2E8F0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.color, size: 26),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.semiBold11Grey
                      .copyWith(color: AppColors.c1E293B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  final Color color;

  const _ServiceItem({
    required this.title,
    required this.icon,
    required this.color,
  });
}
