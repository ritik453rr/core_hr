import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_font_size.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import '../../../../core/common_widgets/app_button.dart';
import '../../../../core/common_widgets/app_network_image.dart';
import '../../../../core/common_widgets/app_refresh_indicator.dart';
import '../../../../core/common_widgets/app_text.dart';
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
          title: const AppText(
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
                            const AppNetworkImage(
                              imgUrl:
                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                              width: 40,
                              height: 40,
                              borderRadius: 20,

                            ),
                            14.w,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(member.name, style: AppTextStyle.bold14),
                                  2.h,
                                  AppText(member.role,
                                      style: AppTextStyle.regular12Grey),
                                  4.h,
                                  AppText('Location: ${member.location}',
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
                              child: AppText(
                                member.attendanceStatus,
                                style: TextStyle(
                                  fontSize: AppFontSize.font11,
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
                                AppText(req.employeeName,
                                    style: AppTextStyle.bold14),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: AppText(
                                    req.requestType,
                                    style: const TextStyle(
                                      fontSize: AppFontSize.font11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.c2563EB,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            6.h,
                            AppText(req.details,
                                style: AppTextStyle.regular13Grey
                                    .copyWith(color: AppColors.c334155)),
                            4.h,
                            AppText('Requested: ${req.date}',
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
                                      child: const AppText('Reject'),
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
                              return AppText(
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
