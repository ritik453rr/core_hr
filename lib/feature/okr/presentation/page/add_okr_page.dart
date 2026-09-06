import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/okr_controller.dart';

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
              GetBuilder<OkrController>(
                id: OkrController.addOkrFormId,
                builder: (controller) {
                  return DropdownButtonFormField<String>(
                    initialValue: controller.selectedQuarter,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    items: ['Q3 2026', 'Q4 2026', 'Q1 2027']
                        .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.setQuarter(val);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Objective Title *',
                hintText: 'e.g. Increase product adoption in APAC region',
                controller: controller.objectiveTitleController,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Primary Key Result *',
                hintText: 'e.g. Onboard 20 new enterprise clients',
                controller: controller.keyResultController,
              ),
              const SizedBox(height: 24),

              AppButton(
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
