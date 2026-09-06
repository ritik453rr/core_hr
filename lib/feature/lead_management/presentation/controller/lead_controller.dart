import 'package:core_hr/core/constants/shared_imports.dart';

class BusinessLead {
  final String clientName;
  final String companyName;
  final String phone;
  final String email;
  final double dealValue;
  final String stage; // New, In Discussion, Proposal Sent, Closed Won, Lost
  final String notes;
  final String createdDate;

  BusinessLead({
    required this.clientName,
    required this.companyName,
    required this.phone,
    required this.email,
    required this.dealValue,
    required this.stage,
    required this.notes,
    required this.createdDate,
  });
}

class LeadController extends GetxController {
  static const String leadsListId = 'leads_list';
  static const String addLeadFormId = 'add_lead_form';

  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dealValueController = TextEditingController();
  final notesController = TextEditingController();
  String selectedStage = 'New';

  String searchQuery = '';

  List<BusinessLead> leadList = <BusinessLead>[
    BusinessLead(
      clientName: 'Robert Vance',
      companyName: 'Apex Innovations',
      phone: '+1 (555) 234-5678',
      email: 'robert@apexinno.com',
      dealValue: 25000,
      stage: 'Proposal Sent',
      notes: 'Interested in enterprise cloud package.',
      createdDate: 'Aug 04, 2026',
    ),
    BusinessLead(
      clientName: 'Sarah Jenkins',
      companyName: 'Nexus Global Ltd.',
      phone: '+1 (555) 876-5432',
      email: 'sjenkins@nexus.com',
      dealValue: 60000,
      stage: 'In Discussion',
      notes: 'Follow-up demo scheduled next Tuesday.',
      createdDate: 'Aug 02, 2026',
    ),
    BusinessLead(
      clientName: 'David Lee',
      companyName: 'Summit Freight Services',
      phone: '+1 (555) 432-1098',
      email: 'david@summitfreight.com',
      dealValue: 18000,
      stage: 'Closed Won',
      notes: 'Contract signed for 1 year service.',
      createdDate: 'Jul 28, 2026',
    ),
  ];

  List<BusinessLead> get filteredLeads {
    if (searchQuery.trim().isEmpty) return leadList;
    final query = searchQuery.toLowerCase();
    return leadList.where((lead) {
      return lead.clientName.toLowerCase().contains(query) ||
          lead.companyName.toLowerCase().contains(query) ||
          lead.stage.toLowerCase().contains(query);
    }).toList();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    update([leadsListId]);
  }

  void setStage(String stage) {
    selectedStage = stage;
    update([addLeadFormId]);
  }

  void addNewLead() {
    final client = nameController.text.trim();
    final company = companyController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final deal = double.tryParse(dealValueController.text.trim()) ?? 0.0;
    final notes = notesController.text.trim();

    if (client.isEmpty || company.isEmpty || phone.isEmpty) {
      AppToast.showToast(
        message: 'Please enter client name, company, and phone number.',
        isSuccess: false,
      );
      return;
    }

    final newLead = BusinessLead(
      clientName: client,
      companyName: company,
      phone: phone,
      email: email.isEmpty ? 'N/A' : email,
      dealValue: deal,
      stage: selectedStage,
      notes: notes.isEmpty ? 'No notes added.' : notes,
      createdDate: 'Aug 05, 2026',
    );

    leadList.insert(0, newLead);

    nameController.clear();
    companyController.clear();
    phoneController.clear();
    emailController.clear();
    dealValueController.clear();
    notesController.clear();

    update([leadsListId]);
    Get.back();
    AppToast.showToast(
      message: 'New customer lead captured successfully.',
      isSuccess: true,
    );
  }
}
