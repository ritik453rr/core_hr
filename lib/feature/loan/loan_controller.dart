import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanRequest {
  final String loanType;
  final double amount;
  final int tenureMonths;
  final double monthlyEmi;
  final String purpose;
  final String status;
  final String appliedDate;

  LoanRequest({
    required this.loanType,
    required this.amount,
    required this.tenureMonths,
    required this.monthlyEmi,
    required this.purpose,
    required this.status,
    required this.appliedDate,
  });
}

class LoanController extends GetxController {
  // Form controllers
  var selectedLoanType = 'Personal Loan'.obs;
  final amountController = TextEditingController();
  final tenureController = TextEditingController();
  final purposeController = TextEditingController();

  var loanRequests = <LoanRequest>[
    LoanRequest(
      loanType: 'Emergency Loan',
      amount: 50000,
      tenureMonths: 12,
      monthlyEmi: 4350,
      purpose: 'Medical emergency expense',
      status: 'Approved',
      appliedDate: 'Jun 15, 2026',
    ),
    LoanRequest(
      loanType: 'Personal Loan',
      amount: 100000,
      tenureMonths: 24,
      monthlyEmi: 4600,
      purpose: 'Home renovation',
      status: 'Pending',
      appliedDate: 'Aug 02, 2026',
    ),
  ].obs;

  void submitLoanApplication() {
    final amountText = amountController.text.trim();
    final tenureText = tenureController.text.trim();
    final purposeText = purposeController.text.trim();

    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      Get.snackbar('Invalid Amount', 'Please enter a valid loan amount.', snackPosition: SnackPosition.TOP);
      return;
    }
    if (tenureText.isEmpty || int.tryParse(tenureText) == null) {
      Get.snackbar('Invalid Tenure', 'Please enter tenure in months.', snackPosition: SnackPosition.TOP);
      return;
    }
    if (purposeText.isEmpty) {
      Get.snackbar('Missing Purpose', 'Please enter loan purpose.', snackPosition: SnackPosition.TOP);
      return;
    }

    final amount = double.parse(amountText);
    final tenure = int.parse(tenureText);
    final emi = (amount / tenure) * 1.05; // 5% interest estimate

    final newReq = LoanRequest(
      loanType: selectedLoanType.value,
      amount: amount,
      tenureMonths: tenure,
      monthlyEmi: emi,
      purpose: purposeText,
      status: 'Under HR Review',
      appliedDate: 'Aug 05, 2026',
    );

    loanRequests.insert(0, newReq);
    amountController.clear();
    tenureController.clear();
    purposeController.clear();

    Get.back();
    Get.snackbar('Loan Request Sent', 'Request captured in backend. HR will review shortly.', snackPosition: SnackPosition.TOP);
  }
}
