import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routing/app_routes.dart';
import '../../core/common_widgets/common_button.dart';
import '../attendance/attendance_page.dart';
import '../field_tracking/field_tracking_page.dart';
import '../my_team/my_team_page.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Obx(() => IndexedStack(
            index: controller.selectedNavIndex.value,
            children: [
              _buildHomeDashboard(context, controller),
              const AttendancePage(),
              const FieldTrackingPage(),
              const MyTeamPage(),
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedNavIndex.value,
            onTap: (index) => controller.changeNavIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF2563EB),
            unselectedItemColor: const Color(0xFF94A3B8),
            backgroundColor: Colors.white,
            elevation: 10,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.access_time_filled), label: 'Attendance'),
              BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Tracking'),
              BottomNavigationBarItem(icon: Icon(Icons.group_rounded), label: 'My Team'),
            ],
          )),
    );
  }

  Widget _buildHomeDashboard(BuildContext context, DashboardController controller) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        toolbarHeight: 70,
        title: InkWell(
          onTap: () => Get.toNamed(AppRoutes.profile),
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'AM',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.employeeName.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                  Obx(() => Text(
                        '${controller.employeeRole.value} • ${controller.employeeId.value}',
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                      )),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none, color: Colors.white, size: 26),
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
            onPressed: () {
              Get.snackbar('Notifications', 'No new announcements today.', snackPosition: SnackPosition.TOP);
            },
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Interactive Live Shift & Clock-In Card ---
              _buildClockInCard(controller),
              const SizedBox(height: 20),

              // --- Quick Metrics Banner ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Key Performance Metrics',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  Text(
                    'Real-Time',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2563EB)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildMetricsGrid(controller),
              const SizedBox(height: 24),

              // --- Mobile App Services Grid ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'HR & Field Applications',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  Text(
                    'All Services',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
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
    );
  }

  Widget _buildClockInCard(DashboardController controller) {
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
                    'DAILY WORK SHIFT',
                    style: TextStyle(color: Color(0xFF93C5FD), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        controller.isClockedIn.value ? 'Active Shift in Progress' : 'Not Clocked In Today',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: controller.isClockedIn.value
                          ? const Color(0xFF22C55E).withValues(alpha: 0.2)
                          : Colors.redAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: controller.isClockedIn.value ? const Color(0xFF22C55E) : Colors.redAccent,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: controller.isClockedIn.value ? const Color(0xFF22C55E) : Colors.redAccent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          controller.isClockedIn.value ? 'CLOCKED IN' : 'OFFLINE',
                          style: TextStyle(
                            color: controller.isClockedIn.value ? const Color(0xFF4ADE80) : const Color(0xFFF87171),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
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
                const Icon(Icons.my_location, color: Color(0xFF38BDF8), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() => Text(
                        controller.liveLocation.value,
                        style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => CommonButton(
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
                      controller.isClockedIn.value ? Icons.stop_circle_rounded : Icons.play_circle_fill_rounded,
                      color: controller.isClockedIn.value ? const Color(0xFFDC2626) : const Color(0xFF2563EB),
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.isClockedIn.value ? 'CLOCK OUT' : 'CLOCK IN WITH LOCATION',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: 0.5),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(DashboardController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.1,
      children: [
        Obx(() => _metricTile('Leave Balance', '${controller.leaveBalance.value} Days', Icons.event_available, const Color(0xFF2563EB))),
        Obx(() => _metricTile('OKR Score', '${controller.okrProgress.value}%', Icons.track_changes_rounded, const Color(0xFF7C3AED))),
        Obx(() => _metricTile('Active Leads', '${controller.activeLeads.value} Clients', Icons.business_center_rounded, const Color(0xFFD97706))),
        Obx(() => _metricTile('Team Approvals', '${controller.pendingApprovals.value} Pending', Icons.assignment_turned_in_rounded, const Color(0xFF0D9488))),
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
                Text(title, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {'title': 'Holidays', 'icon': Icons.event_available_rounded, 'route': AppRoutes.holidays, 'color': const Color(0xFF4F46E5)},
      {'title': 'Apply Leave', 'icon': Icons.time_to_leave_rounded, 'route': AppRoutes.leave, 'color': const Color(0xFF10B981)},
      {'title': 'Apply for Loan', 'icon': Icons.account_balance_rounded, 'route': AppRoutes.loan, 'color': const Color(0xFFD97706)},
      {'title': 'Lead Management', 'icon': Icons.business_center_rounded, 'route': AppRoutes.leadManagement, 'color': const Color(0xFFEA580C)},
      {'title': 'HR Documents', 'icon': Icons.folder_shared_rounded, 'route': AppRoutes.hrDocuments, 'color': const Color(0xFFDC2626)},
      {'title': 'OKR & Goals', 'icon': Icons.emoji_events_rounded, 'route': AppRoutes.okr, 'color': const Color(0xFF7C3AED)},
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
        final color = item['color'] as Color? ?? Colors.blue;
        return InkWell(
          onTap: () => Get.toNamed(item['route'] as String),
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
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item['icon'] as IconData, color: color, size: 26),
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'] as String,
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
            child: const Icon(Icons.campaign_rounded, color: Color(0xFFD97706), size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Q3 Performance & Payroll Review',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                ),
                SizedBox(height: 2),
                Text(
                  'Submit all pending appraisal goals by Aug 25.',
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
