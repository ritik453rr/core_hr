import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/common_widgets/common_button.dart';
import 'leave_controller.dart';

class ApplyLeavePage extends StatelessWidget {
  const ApplyLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaveController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Apply for Leave', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Leave Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedLeaveType.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ['Casual Leave', 'Sick Leave', 'Earned Leave', 'Maternity/Paternity Leave']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.selectedLeaveType.value = val;
                    },
                  )),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(const Duration(days: 30)),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) controller.startDate.value = date;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() => Text(
                                  controller.startDate.value == null
                                      ? 'Select Date'
                                      : '${controller.startDate.value!.day}/${controller.startDate.value!.month}/${controller.startDate.value!.year}',
                                  style: TextStyle(
                                    color: controller.startDate.value == null ? const Color(0xFF94A3B8) : Colors.black,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('End Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(const Duration(days: 30)),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) controller.endDate.value = date;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() => Text(
                                  controller.endDate.value == null
                                      ? 'Select Date'
                                      : '${controller.endDate.value!.day}/${controller.endDate.value!.month}/${controller.endDate.value!.year}',
                                  style: TextStyle(
                                    color: controller.endDate.value == null ? const Color(0xFF94A3B8) : Colors.black,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('Reason for Leave', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter reason for your leave request...',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),

              CommonButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF2563EB),
                borderRadius: 12,
                text: 'SUBMIT LEAVE REQUEST',
                textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                onPressed: controller.submitLeaveApplication,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
