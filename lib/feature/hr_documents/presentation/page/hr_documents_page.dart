import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/hr_documents_controller.dart';

class HrDocumentsPage extends StatelessWidget {
  const HrDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HrDocumentsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('HR Documents', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder<HrDocumentsController>(
        id: HrDocumentsController.hrDocumentsId,
        builder: (controller) {
          return Column(
            children: [
              // Filter Tabs
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _chip(controller, 'All'),
                      const SizedBox(width: 8),
                      _chip(controller, 'Salary Slips'),
                      const SizedBox(width: 8),
                      _chip(controller, 'Tax Forms'),
                      const SizedBox(width: 8),
                      _chip(controller, 'Appraisal'),
                      const SizedBox(width: 8),
                      _chip(controller, 'Policies'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Document List
              Expanded(
                child: Builder(
                  builder: (context) {
                    final list = controller.filteredDocuments;
                    if (list.isEmpty) {
                      return const Center(child: Text('No documents in this category.'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: list.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final doc = list[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.picture_as_pdf, color: Color(0xFFDC2626), size: 28),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doc.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text('${doc.category} • ${doc.date} • ${doc.fileSize}',
                                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.download_for_offline, color: Color(0xFF2563EB), size: 28),
                                onPressed: () => controller.downloadDocument(doc),
                                tooltip: 'Download',
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _chip(HrDocumentsController controller, String label) {
    final selected = controller.selectedCategory == label;
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: selected ? Colors.white : const Color(0xFF475569), fontSize: 12)),
      selected: selected,
      selectedColor: const Color(0xFF0F172A),
      backgroundColor: const Color(0xFFF1F5F9),
      onSelected: (_) => controller.setCategory(label),
    );
  }
}
