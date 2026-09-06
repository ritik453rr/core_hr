import 'package:core_hr/core/constants/shared_imports.dart';

class HrDocumentItem {
  final String title;
  final String category; // Salary Slips, Tax Forms, Appraisal, Policies
  final String date;
  final String fileSize;
  final String fileFormat;

  HrDocumentItem({
    required this.title,
    required this.category,
    required this.date,
    required this.fileSize,
    required this.fileFormat,
  });
}

class HrDocumentsController extends GetxController {
  static const String hrDocumentsId = 'hr_documents';

  String selectedCategory = 'All';

  List<HrDocumentItem> documents = <HrDocumentItem>[
    HrDocumentItem(
      title: 'Salary Slip - July 2026',
      category: 'Salary Slips',
      date: 'Aug 01, 2026',
      fileSize: '340 KB',
      fileFormat: 'PDF',
    ),
    HrDocumentItem(
      title: 'Salary Slip - June 2026',
      category: 'Salary Slips',
      date: 'Jul 01, 2026',
      fileSize: '335 KB',
      fileFormat: 'PDF',
    ),
    HrDocumentItem(
      title: 'Form 60 / Form 16 Annual Tax Summary',
      category: 'Tax Forms',
      date: 'May 15, 2026',
      fileSize: '1.2 MB',
      fileFormat: 'PDF',
    ),
    HrDocumentItem(
      title: 'Annual Performance Appraisal Letter 2025-26',
      category: 'Appraisal',
      date: 'Apr 10, 2026',
      fileSize: '650 KB',
      fileFormat: 'PDF',
    ),
    HrDocumentItem(
      title: 'Employment Offer Letter & Terms',
      category: 'Onboarding',
      date: 'Jan 15, 2024',
      fileSize: '890 KB',
      fileFormat: 'PDF',
    ),
    HrDocumentItem(
      title: 'Company Code of Conduct & HR Policy 2026',
      category: 'Policies',
      date: 'Jan 01, 2026',
      fileSize: '2.4 MB',
      fileFormat: 'PDF',
    ),
  ];

  List<HrDocumentItem> get filteredDocuments {
    if (selectedCategory == 'All') return documents;
    return documents.where((doc) => doc.category == selectedCategory).toList();
  }

  void setCategory(String category) {
    selectedCategory = category;
    update([hrDocumentsId]);
  }

  void downloadDocument(HrDocumentItem doc) {
    AppToast.showToast(
      message:
          'Saved "${doc.title}.${doc.fileFormat.toLowerCase()}" to device storage.',
      isSuccess: true,
    );
  }
}
