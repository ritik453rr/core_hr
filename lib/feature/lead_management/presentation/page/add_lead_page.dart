import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/lead_controller.dart';

class AddLeadPage extends StatelessWidget {
  const AddLeadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeadController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Capture Business Lead', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              AppTextField(
                label: 'Client Full Name *',
                hintText: 'e.g. John Doe',
                controller: controller.nameController,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Company / Business Name *',
                hintText: 'e.g. Acme Corp',
                controller: controller.companyController,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Phone Number *',
                hintText: '+1 555-0192',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Email Address',
                hintText: 'client@company.com',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Estimated Deal Value (\$)',
                hintText: 'e.g. 25000',
                controller: controller.dealValueController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              const Text('Lead Stage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              GetBuilder<LeadController>(
                id: LeadController.addLeadFormId,
                builder: (controller) {
                  return DropdownButtonFormField<String>(
                    initialValue: controller.selectedStage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    items: ['New', 'In Discussion', 'Proposal Sent', 'Closed Won', 'Lost']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.setStage(val);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Discussion Notes / Requirements',
                hintText: 'Add key meeting notes or client requirements...',
                controller: controller.notesController,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              AppButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF2563EB),
                borderRadius: 12,
                text: 'SAVE NEW LEAD',
                textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                onPressed: controller.addNewLead,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
