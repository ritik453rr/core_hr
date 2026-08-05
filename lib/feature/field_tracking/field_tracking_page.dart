import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'field_tracking_controller.dart';

class FieldTrackingPage extends StatelessWidget {
  const FieldTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FieldTrackingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Field Staff Live Tracking', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: controller.refreshLocations,
            tooltip: 'Refresh Locations',
          ),
        ],
      ),
      body: Column(
        children: [
          // Simulated Map View Graphic Container
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0284C7), Color(0xFF0369A1)],
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                      itemCount: 24,
                      itemBuilder: (context, index) => Container(decoration: BoxDecoration(border: Border.all(color: Colors.white))),

                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.explore, color: Colors.white, size: 40),
                      const SizedBox(height: 6),
                      const Text(
                        'LIVE SATELLITE GPS ACTIVE',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                            'Tracking ${controller.fieldStaffList.length} Active Field Officers',
                            style: const TextStyle(color: Colors.white70, fontSize: 11),
                          )),
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
            child: Obx(() => Row(
                  children: [
                    _filterChip(controller, 'All'),
                    const SizedBox(width: 8),
                    _filterChip(controller, 'Active'),
                    const SizedBox(width: 8),
                    _filterChip(controller, 'Idle'),
                    const SizedBox(width: 8),
                    _filterChip(controller, 'Off Duty'),
                  ],
                )),
          ),

          // Field Staff List
          Expanded(
            child: Obx(() {
              final list = controller.filteredStaff;
              if (list.isEmpty) {
                return const Center(child: Text('No field staff match filter.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final staff = list[index];
                  final isActive = staff.status == 'Active';
                  final isIdle = staff.status == 'Idle';

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
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color(0xFF0F172A),
                                  child: Text(staff.staffName[0], style: const TextStyle(color: Colors.white, fontSize: 13)),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(staff.staffName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    Text('${staff.designation} (${staff.staffId})', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xFFDCFCE7)
                                    : isIdle
                                        ? const Color(0xFFFEF3C7)
                                        : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                staff.status,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isActive
                                      ? const Color(0xFF166534)
                                      : isIdle
                                          ? const Color(0xFF92400E)
                                          : const Color(0xFF475569),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Color(0xFF0284C7)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                staff.currentArea,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text('Coordinates: ${staff.latLong}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.battery_std, size: 14, color: Color(0xFF16A34A)),
                                const SizedBox(width: 4),
                                Text('Battery: ${staff.batteryLevel}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                              ],
                            ),
                            Text('Last Ping: ${staff.lastPingTime}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(FieldTrackingController controller, String label) {
    final selected = controller.selectedFilter.value == label;
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: selected ? Colors.white : const Color(0xFF475569), fontSize: 12)),
      selected: selected,
      selectedColor: const Color(0xFF0F172A),
      backgroundColor: const Color(0xFFF1F5F9),
      onSelected: (_) => controller.selectedFilter.value = label,
    );
  }
}
