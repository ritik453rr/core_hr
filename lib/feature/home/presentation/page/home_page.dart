import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/home_controller.dart';
import '../widgets/home_app_bar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onTapProfile: () {
          Get.toNamed(AppRoutes.profile);
        },
      ),

      body: GetBuilder<HomeController>(
        id: HomeBuilderIds.home,
        builder: (_) => AppRefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Interactive Live Shift & Clock-In Card ---
                  _buildClockInCard(),
                  const SizedBox(height: 20),

                  // --- Quick Metrics Banner ---
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.kKeyPerformanceMetrics,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        StringConstants.kRealTime,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildMetricsGrid(),
                  const SizedBox(height: 24),

                  // --- Mobile App Services Grid ---
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.kHrAndFieldApplications,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        StringConstants.kAllServices,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildServicesGrid(),
                  const SizedBox(height: 24),

                  // --- Recent Company Announcement Card ---
                  _buildAnnouncementCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClockInCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    StringConstants.kDailyWorkShift,
                    style: TextStyle(
                      color: Color(0xFF93C5FD),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.isClockedIn
                        ? StringConstants.kActiveShiftInProgress
                        : StringConstants.kNotClockedInToday,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: controller.isClockedIn
                      ? const Color(0xFF22C55E).withValues(alpha: 0.2)
                      : Colors.redAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: controller.isClockedIn
                        ? const Color(0xFF22C55E)
                        : Colors.redAccent,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: controller.isClockedIn
                          ? const Color(0xFF22C55E)
                          : Colors.redAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      controller.isClockedIn
                          ? StringConstants.kClockedIn
                          : StringConstants.kOffline,
                      style: TextStyle(
                        color: controller.isClockedIn
                            ? const Color(0xFF4ADE80)
                            : const Color(0xFFF87171),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.my_location,
                  color: Color(0xFF38BDF8),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controller.liveLocation,
                    style: const TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            width: double.infinity,
            height: 48,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF0F172A),
            borderRadius: 12,
            onPressed: controller.toggleClockIn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.isClockedIn
                      ? Icons.stop_circle_rounded
                      : Icons.play_circle_fill_rounded,
                  color: controller.isClockedIn
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF2563EB),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  controller.isClockedIn
                      ? StringConstants.kClockOut
                      : StringConstants.kClockInWithLocation,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.1,
      children: [
        _metricTile(
          StringConstants.kLeaveBalance,
          '${controller.leaveBalance} ${StringConstants.kDays}',
          Icons.event_available,
          const Color(0xFF2563EB),
        ),
        _metricTile(
          StringConstants.kOkrScore,
          '${controller.okrProgress}${StringConstants.kPercent}',
          Icons.track_changes_rounded,
          const Color(0xFF7C3AED),
        ),
        _metricTile(
          StringConstants.kActiveLeads,
          '${controller.activeLeads} ${StringConstants.kClients}',
          Icons.business_center_rounded,
          const Color(0xFFD97706),
        ),
        _metricTile(
          StringConstants.kTeamApprovals,
          '${controller.pendingApprovals} ${StringConstants.kPending}',
          Icons.assignment_turned_in_rounded,
          const Color(0xFF0D9488),
        ),
      ],
    );
  }

  Widget _metricTile(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    const services = [
      _ServiceItem(
        title: StringConstants.kHolidays,
        icon: Icons.event_available_rounded,
        route: AppRoutes.holidays,
        color: Color(0xFF4F46E5),
      ),
      _ServiceItem(
        title: StringConstants.kApplyLeave,
        icon: Icons.time_to_leave_rounded,
        route: AppRoutes.leave,
        color: Color(0xFF10B981),
      ),
      _ServiceItem(
        title: StringConstants.kApplyForLoan,
        icon: Icons.account_balance_rounded,
        route: AppRoutes.loan,
        color: Color(0xFFD97706),
      ),
      _ServiceItem(
        title: StringConstants.kLeadManagement,
        icon: Icons.business_center_rounded,
        route: AppRoutes.leadManagement,
        color: Color(0xFFEA580C),
      ),
      _ServiceItem(
        title: StringConstants.kHrDocuments,
        icon: Icons.folder_shared_rounded,
        route: AppRoutes.hrDocuments,
        color: Color(0xFFDC2626),
      ),
      _ServiceItem(
        title: StringConstants.kOkrAndGoals,
        icon: Icons.emoji_events_rounded,
        route: AppRoutes.okr,
        color: Color(0xFF7C3AED),
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
          onTap: () => Get.toNamed(item.route),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
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
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnnouncementCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.campaign_rounded,
              color: Color(0xFFD97706),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstants.kAnnouncementTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  StringConstants.kAnnouncementSubtitle,
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  final String route;
  final Color color;

  const _ServiceItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
}
