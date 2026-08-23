import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/common_widgets/common_button.dart';
import 'my_team_controller.dart';

class MyTeamPage extends StatelessWidget {
  const MyTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyTeamController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text('My Team Management', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF0F172A),
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Color(0xFF38BDF8),
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF94A3B8),
            tabs: [
              Tab(text: 'Team Reportees'),
              Tab(text: 'Pending Approvals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Team Reportees List
            Obx(() => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.teamMembers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final member = controller.teamMembers[index];
                    final isPresent = member.attendanceStatus == 'Present';
                    final isOnLeave = member.attendanceStatus == 'On Leave';

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF0F172A),
                            child: Text(
                              member.name.split(' ').map((n) => n[0]).join(''),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                const SizedBox(height: 2),
                                Text(member.role, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                                const SizedBox(height: 4),
                                Text('Location: ${member.location}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPresent
                                  ? const Color(0xFFDCFCE7)
                                  : isOnLeave
                                      ? const Color(0xFFFEF3C7)
                                      : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              member.attendanceStatus,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isPresent
                                    ? const Color(0xFF166534)
                                    : isOnLeave
                                        ? const Color(0xFF92400E)
                                        : const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),

            // Tab 2: Pending Approvals
            Obx(() => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.pendingApprovals.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final req = controller.pendingApprovals[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(req.employeeName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(req.requestType,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(req.details, style: const TextStyle(color: Color(0xFF334155), fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          Text('Requested: ${req.date}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                          const SizedBox(height: 12),

                          Obx(() {
                            if (req.status.value == 'Pending') {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFFDC2626),
                                      side: const BorderSide(color: Color(0xFFFCA5A5)),
                                    ),
                                    onPressed: () => controller.rejectRequest(req),
                                    child: const Text('Reject'),
                                  ),
                                  const SizedBox(width: 8),
                                  CommonButton(
                                    backgroundColor: const Color(0xFF16A34A),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    text: 'Approve',
                                    onPressed: () => controller.approveRequest(req),
                                  ),
                                ],
                              );
                            }
                            return Text(
                              'Decision: ${req.status.value}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: req.status.value == 'Approved' ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
