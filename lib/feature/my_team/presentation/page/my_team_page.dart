import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/my_team_controller.dart';

/// Page for managing team reportees and handling pending approvals for requests.
class MyTeamPage extends GetView<MyTeamController> {
  const MyTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Team Management',
            style: AppTextStyle.bold18White,
          ),
          backgroundColor: AppColors.c0F172A,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Color(0xFF38BDF8),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.c94A3B8,
            tabs: [
              Tab(text: 'Team Reportees'),
              Tab(text: 'Pending Approvals'),
            ],
          ),
        ),
        body: GetBuilder<MyTeamController>(
          id: MyTeamController.myTeamId,
          builder: (controller) {
            return TabBarView(
              children: [
                // Tab 1: Team Reportees List
                AppRefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    controller.update([MyTeamController.myTeamId]);
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.teamMembers.length,
                    separatorBuilder: (_, _) => 12.h,
                    itemBuilder: (context, index) {
                      final member = controller.teamMembers[index];
                      final isPresent = member.attendanceStatus == 'Present';
                      final isOnLeave = member.attendanceStatus == 'On Leave';

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.cE2E8F0),
                        ),
                        child: Row(
                          children: [
                            AppNetworkImage(
                              imgUrl:
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                              width: 40,
                              height: 40,
                              borderRadius: 20,
                              placeholder: (context, url) => CircleAvatar(
                                backgroundColor: AppColors.c0F172A,
                                child: Text(
                                  member.name
                                      .split(' ')
                                      .map((n) => n[0])
                                      .join(''),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                backgroundColor: AppColors.c0F172A,
                                child: Text(
                                  member.name
                                      .split(' ')
                                      .map((n) => n[0])
                                      .join(''),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            14.w,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(member.name, style: AppTextStyle.bold14),
                                  2.h,
                                  Text(member.role,
                                      style: AppTextStyle.regular12Grey),
                                  4.h,
                                  Text('Location: ${member.location}',
                                      style: AppTextStyle.regular11White60
                                          .copyWith(color: AppColors.c94A3B8)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isPresent
                                    ? AppColors.cDCFCE7
                                    : isOnLeave
                                        ? AppColors.cFEF3C7
                                        : AppColors.cF1F5F9,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                member.attendanceStatus,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isPresent
                                      ? AppColors.c166534
                                      : isOnLeave
                                          ? AppColors.c92400E
                                          : AppColors.c475569,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Tab 2: Pending Approvals
                AppRefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    controller.update([MyTeamController.myTeamId]);
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.pendingApprovals.length,
                    separatorBuilder: (_, _) => 12.h,
                    itemBuilder: (context, index) {
                      final req = controller.pendingApprovals[index];
                      final isApproved = req.status == 'Approved';
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.cE2E8F0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(req.employeeName,
                                    style: AppTextStyle.bold14),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    req.requestType,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.c2563EB,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            6.h,
                            Text(req.details,
                                style: AppTextStyle.regular13Grey
                                    .copyWith(color: AppColors.c334155)),
                            4.h,
                            Text('Requested: ${req.date}',
                                style: AppTextStyle.regular11White60
                                    .copyWith(color: AppColors.c94A3B8)),
                            12.h,
                            Builder(builder: (context) {
                              if (req.status == 'Pending') {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.cDC2626,
                                        side: const BorderSide(
                                            color: Color(0xFFFCA5A5)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                      onPressed: () =>
                                          controller.rejectRequest(req),
                                      child: const Text('Reject'),
                                    ),
                                    8.w,
                                    AppButton(
                                      title: 'Approve',
                                      onPressed: () =>
                                          controller.approveRequest(req),
                                    ),
                                  ],
                                );
                              }
                              return Text(
                                'Decision: ${req.status}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isApproved
                                      ? AppColors.c16A34A
                                      : AppColors.cDC2626,
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
