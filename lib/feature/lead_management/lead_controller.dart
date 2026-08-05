import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dealValueController = TextEditingController();
  final notesController = TextEditingController();
  var selectedStage = 'New'.obs;

  var searchQuery = ''.obs;

  var leadList = <BusinessLead>[
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
  ].obs;

  List<BusinessLead> get filteredLeads {
    if (searchQuery.value.trim().isEmpty) return leadList;
    final query = searchQuery.value.toLowerCase();
    return leadList.where((lead) {
      return lead.clientName.toLowerCase().contains(query) ||
          lead.companyName.toLowerCase().contains(query) ||
          lead.stage.toLowerCase().contains(query);
    }).toList();
  }

  void addNewLead() {
    final client = nameController.text.trim();
    final company = companyController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final deal = double.tryParse(dealValueController.text.trim()) ?? 0.0;
    final notes = notesController.text.trim();

    if (client.isEmpty || company.isEmpty || phone.isEmpty) {
      Get.snackbar('Incomplete Info', 'Please enter client name, company, and phone number.', snackPosition: SnackPosition.TOP);
      return;
    }

    final newLead = BusinessLead(
      clientName: client,
      companyName: company,
      phone: phone,
      email: email.isEmpty ? 'N/A' : email,
      dealValue: deal,
      stage: selectedStage.value,
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

    Get.back();
    Get.snackbar('Lead Saved', 'New customer lead captured successfully.', snackPosition: SnackPosition.TOP);
  }
}
