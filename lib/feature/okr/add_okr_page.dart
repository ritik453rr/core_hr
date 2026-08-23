import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/common_widgets/common_button.dart';
import 'okr_controller.dart';

class AddOkrPage extends StatelessWidget {
  const AddOkrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OkrController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('New Objective & Target', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              const Text('Target Quarter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedQuarter.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    items: ['Q3 2026', 'Q4 2026', 'Q1 2027']
                        .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.selectedQuarter.value = val;
                    },
                  )),
              const SizedBox(height: 16),

              const Text('Objective Title *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.objectiveTitleController,
                decoration: InputDecoration(
                  hintText: 'e.g. Increase product adoption in APAC region',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Primary Key Result *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.keyResultController,
                decoration: InputDecoration(
                  hintText: 'e.g. Onboard 20 new enterprise clients',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),

              CommonButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF7C3AED),
                borderRadius: 12,
                text: 'CREATE OBJECTIVE',
                textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                onPressed: controller.addObjective,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
