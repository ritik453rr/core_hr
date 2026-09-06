import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/loan_controller.dart';

class ApplyLoanPage extends StatelessWidget {
  const ApplyLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoanController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Apply for Loan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              const Text('Loan Scheme Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              GetBuilder<LoanController>(
                id: LoanController.applyLoanFormId,
                builder: (controller) {
                  return DropdownButtonFormField<String>(
                    initialValue: controller.selectedLoanType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ['Personal Loan', 'Emergency Loan', 'Education Assistance', 'Equipment Loan']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.setLoanType(val);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Requested Amount (₹)',
                hintText: 'e.g. 50000',
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.currency_rupee,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Tenure (Months)',
                hintText: 'e.g. 12',
                controller: controller.tenureController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.access_time,
              ),
              const SizedBox(height: 16),

              AppTextField(
                label: 'Purpose / Remarks',
                hintText: 'State reason for applying loan...',
                controller: controller.purposeController,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              AppButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF2563EB),
                borderRadius: 12,
                text: 'SUBMIT LOAN APPLICATION',
                textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                onPressed: controller.submitLoanApplication,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
