import 'package:core_hr/core/constants/shared_imports.dart';

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
  static const String loanId = 'loan';
  static const String applyLoanFormId = 'apply_loan_form';

  // Form controllers
  String selectedLoanType = 'Personal Loan';
  final amountController = TextEditingController();
  final tenureController = TextEditingController();
  final purposeController = TextEditingController();

  List<LoanRequest> loanRequests = <LoanRequest>[
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
  ];

  void setLoanType(String type) {
    selectedLoanType = type;
    update([applyLoanFormId]);
  }

  void submitLoanApplication() {
    final amountText = amountController.text.trim();
    final tenureText = tenureController.text.trim();
    final purposeText = purposeController.text.trim();

    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      AppToast.showToast(
        message: 'Please enter a valid loan amount.',
        isSuccess: false,
      );
      return;
    }
    if (tenureText.isEmpty || int.tryParse(tenureText) == null) {
      AppToast.showToast(
        message: 'Please enter tenure in months.',
        isSuccess: false,
      );
      return;
    }
    if (purposeText.isEmpty) {
      AppToast.showToast(
        message: 'Please enter loan purpose.',
        isSuccess: false,
      );
      return;
    }

    final amount = double.parse(amountText);
    final tenure = int.parse(tenureText);
    final emi = (amount / tenure) * 1.05; // 5% interest estimate

    final newReq = LoanRequest(
      loanType: selectedLoanType,
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

    update([loanId, applyLoanFormId]);
    Get.back();
    AppToast.showToast(
      message: 'Request captured in backend. HR will review shortly.',
      isSuccess: true,
    );
  }
}
