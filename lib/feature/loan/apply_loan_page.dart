import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/common_widgets/common_button.dart';
import 'loan_controller.dart';

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
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedLoanType.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ['Personal Loan', 'Emergency Loan', 'Education Assistance', 'Equipment Loan']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.selectedLoanType.value = val;
                    },
                  )),
              const SizedBox(height: 16),

              const Text('Requested Amount (₹)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 50000',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Tenure (Months)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.tenureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 12',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Purpose / Remarks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.purposeController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'State reason for applying loan...',
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
