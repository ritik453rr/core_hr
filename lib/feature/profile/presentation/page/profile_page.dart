import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.badge_outlined, color: Colors.white),
            tooltip: 'Download ID Card',
            onPressed: controller.downloadIdCard,
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            tooltip: 'Edit Profile Info',
            onPressed: controller.editProfileInfo,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GetBuilder<ProfileController>(
        id: ProfileController.profileId,
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Employee Header Card ---
                _buildProfileHeaderCard(controller),
                const SizedBox(height: 20),

                // --- Stats Summary Row ---
                _buildStatsRow(controller),
                const SizedBox(height: 20),

                // --- Work & Personal Details ---
                const Text(
                  'Personal & Employment Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoCard(controller),
                const SizedBox(height: 24),

                // --- Account Actions ---
                const Text(
                  'Account & Security Actions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),
                _buildActionsCard(controller),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeaderCard(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: AppNetworkImage(
                  imgUrl:
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
                  width: 72,
                  height: 72,
                  borderRadius: 36,
                  placeholder: (context, url) => Container(
                    width: 72,
                    height: 72,
                    color: const Color(0xFF2563EB),
                    child: const Center(
                      child: Text(
                        'AM',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 72,
                    height: 72,
                    color: const Color(0xFF2563EB),
                    child: const Center(
                      child: Text(
                        'AM',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.role,
                      style: const TextStyle(
                        color: Color(0xFF93C5FD),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        controller.empId,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(ProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: _statTile(
            'Experience',
            controller.totalExperience,
            Icons.work_history_rounded,
            const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statTile(
            'Leave Bal.',
            controller.leaveBalance,
            Icons.event_available_rounded,
            const Color(0xFF10B981),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statTile(
            'Active Loan',
            controller.activeLoan,
            Icons.account_balance_rounded,
            const Color(0xFFD97706),
          ),
        ),
      ],
    );
  }

  Widget _statTile(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ProfileController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _infoTile(
            Icons.business_rounded,
            'Department',
            controller.department,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.mail_outline_rounded,
            'Email Address',
            controller.email,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.phone_iphone_rounded,
            'Phone Number',
            controller.phone,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.calendar_today_rounded,
            'Date of Joining',
            controller.joiningDate,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(Icons.schedule_rounded, 'Work Shift', controller.workShift),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.supervisor_account_rounded,
            'Reporting Manager',
            controller.manager,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.location_on_outlined,
            'Office Location',
            controller.location,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String label,
    String value, {
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard(ProfileController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.badge_rounded, color: Color(0xFF0284C7)),
            title: const Text(
              'Download Employee ID Card',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.download_rounded,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
            onTap: controller.downloadIdCard,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
            title: const Text(
              'Sign Out of Account',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFDC2626),
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFDC2626),
            ),
            onTap: controller.logout,
          ),
        ],
      ),
    );
  }
}
