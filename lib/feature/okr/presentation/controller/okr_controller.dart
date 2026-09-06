import 'package:core_hr/core/constants/shared_imports.dart';

class KeyResult {
  final String title;
  double progress; // 0.0 to 1.0

  KeyResult({required this.title, required this.progress});
}

class ObjectiveItem {
  final String title;
  final String quarter;
  final List<KeyResult> keyResults;

  ObjectiveItem({required this.title, required this.quarter, required this.keyResults});

  double get overallProgress {
    if (keyResults.isEmpty) return 0.0;
    final total = keyResults.fold(0.0, (sum, kr) => sum + kr.progress);
    return total / keyResults.length;
  }
}

class OkrController extends GetxController {
  static const String okrId = 'okr';
  static const String addOkrFormId = 'add_okr_form';

  final objectiveTitleController = TextEditingController();
  final keyResultController = TextEditingController();
  String selectedQuarter = 'Q3 2026';

  List<ObjectiveItem> objectives = <ObjectiveItem>[
    ObjectiveItem(
      title: 'Expand Enterprise Client Base in West Coast',
      quarter: 'Q3 2026',
      keyResults: [
        KeyResult(title: 'Close 5 new enterprise accounts', progress: 0.8),
        KeyResult(title: 'Generate \$150k in new ARR', progress: 0.6),
        KeyResult(title: 'Achieve 95% client satisfaction score', progress: 0.9),
      ],
    ),
    ObjectiveItem(
      title: 'Optimize Field Operations & Live Tracking Workflow',
      quarter: 'Q3 2026',
      keyResults: [
        KeyResult(title: 'Reduce check-in latency by 40%', progress: 0.7),
        KeyResult(title: 'Onboard 100% field employees on HR Book app', progress: 1.0),
      ],
    ),
  ];

  double get overallOkrScore {
    if (objectives.isEmpty) return 0.0;
    final total = objectives.fold(0.0, (sum, obj) => sum + obj.overallProgress);
    return (total / objectives.length) * 100;
  }

  void setQuarter(String quarter) {
    selectedQuarter = quarter;
    update([addOkrFormId]);
  }

  void updateKeyResultProgress(KeyResult kr, double newProgress) {
    kr.progress = newProgress;
    update([okrId]);
  }

  void addObjective() {
    final title = objectiveTitleController.text.trim();
    final krText = keyResultController.text.trim();

    if (title.isEmpty || krText.isEmpty) {
      AppToast.showToast(
        message: 'Please enter objective title and at least one key result.',
        isSuccess: false,
      );
      return;
    }

    objectives.insert(
      0,
      ObjectiveItem(
        title: title,
        quarter: selectedQuarter,
        keyResults: [
          KeyResult(title: krText, progress: 0.1),
        ],
      ),
    );

    objectiveTitleController.clear();
    keyResultController.clear();

    update([okrId, addOkrFormId]);
    Get.back();
    AppToast.showToast(
      message: 'New performance target added to your quarterly dashboard.',
      isSuccess: true,
    );
  }
}
