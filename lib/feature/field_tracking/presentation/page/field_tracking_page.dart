import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/field_tracking_controller.dart';

/// Page for monitoring field staff locations and status in real-time.
class FieldTrackingPage extends GetView<FieldTrackingController> {
  const FieldTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Field Staff Live Tracking',
          style: AppTextStyle.bold18White,
        ),
        backgroundColor: AppColors.c0F172A,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: controller.refreshLocations,
            tooltip: 'Refresh Locations',
          ),
        ],
      ),
      body: GetBuilder<FieldTrackingController>(
        id: FieldTrackingController.fieldTrackingId,
        builder: (controller) {
          return Column(
            children: [
              // Simulated Map View Graphic Container
              Container(
                height: 160,
                width: Get.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.c0284C7, Color(0xFF0369A1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.15,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6),
                          itemCount: 24,
                          itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white))),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.explore, color: Colors.white, size: 40),
                          6.h,
                          const Text(
                            'LIVE SATELLITE GPS ACTIVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontSize: 13),
                          ),
                          4.h,
                          Text(
                            'Tracking ${controller.fieldStaffList.length} Active Field Officers',
                            style: const TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Status Filter Tabs
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    _filterChip(controller, 'All'),
                    8.w,
                    _filterChip(controller, 'Active'),
                    8.w,
                    _filterChip(controller, 'Idle'),
                    8.w,
                    _filterChip(controller, 'Off Duty'),
                  ],
                ),
              ),

              // Field Staff List
              Expanded(
                child: Builder(
                  builder: (context) {
                    final list = controller.filteredStaff;
                    if (list.isEmpty) {
                      return const Center(
                          child: Text('No field staff match filter.'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: list.length,
                      separatorBuilder: (_, _) => 12.h,
                      itemBuilder: (context, index) {
                        final staff = list[index];
                        final isActive = staff.status == 'Active';
                        final isIdle = staff.status == 'Idle';

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
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 16,
                                        backgroundColor: AppColors.c0F172A,
                                        child: Icon(Icons.person,
                                            color: Colors.white, size: 18),
                                      ),
                                      10.w,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(staff.staffName,
                                              style: AppTextStyle.bold14),
                                          Text(
                                              '${staff.designation} (${staff.staffId})',
                                              style:
                                                  AppTextStyle.regular11White60
                                                      .copyWith(
                                                          color: AppColors
                                                              .c64748B)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? AppColors.cDCFCE7
                                          : isIdle
                                              ? AppColors.cFEF3C7
                                              : AppColors.cF1F5F9,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      staff.status,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isActive
                                            ? AppColors.c166534
                                            : isIdle
                                                ? AppColors.c92400E
                                                : AppColors.c4B5563,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              12.h,

                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: AppColors.c0284C7),
                                  6.w,
                                  Expanded(
                                    child: Text(
                                      staff.currentArea,
                                      style: AppTextStyle.semiBold14,
                                    ),
                                  ),
                                ],
                              ),
                              4.h,
                              Padding(
                                padding: const EdgeInsets.only(left: 22.0),
                                child: Text('Coordinates: ${staff.latLong}',
                                    style: AppTextStyle.regular11White60
                                        .copyWith(color: AppColors.c94A3B8)),
                              ),
                              8.h,

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.battery_std,
                                          size: 14, color: AppColors.c16A34A),
                                      4.w,
                                      Text('Battery: ${staff.batteryLevel}',
                                          style: AppTextStyle.regular11White60
                                              .copyWith(
                                                  color: AppColors.c64748B)),
                                    ],
                                  ),
                                  Text('Last Ping: ${staff.lastPingTime}',
                                      style: AppTextStyle.regular11White60
                                          .copyWith(color: AppColors.c94A3B8)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterChip(FieldTrackingController controller, String label) {
    final selected = controller.selectedFilter == label;
    return ChoiceChip(
      label: Text(label,
          style: TextStyle(
              color: selected ? Colors.white : AppColors.c475569,
              fontSize: 12)),
      selected: selected,
      selectedColor: AppColors.c0F172A,
      backgroundColor: AppColors.cF1F5F9,
      onSelected: (_) => controller.setFilter(label),
    );
  }
}
