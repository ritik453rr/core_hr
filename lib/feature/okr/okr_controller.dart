import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final objectiveTitleController = TextEditingController();
  final keyResultController = TextEditingController();
  var selectedQuarter = 'Q3 2026'.obs;

  var objectives = <ObjectiveItem>[
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
  ].obs;

  double get overallOkrScore {
    if (objectives.isEmpty) return 0.0;
    final total = objectives.fold(0.0, (sum, obj) => sum + obj.overallProgress);
    return (total / objectives.length) * 100;
  }

  void updateKeyResultProgress(KeyResult kr, double newProgress) {
    kr.progress = newProgress;
    objectives.refresh();
  }

  void addObjective() {
    final title = objectiveTitleController.text.trim();
    final krText = keyResultController.text.trim();

    if (title.isEmpty || krText.isEmpty) {
      Get.snackbar('Missing Inputs', 'Please enter objective title and at least one key result.', snackPosition: SnackPosition.TOP);
      return;
    }

    objectives.insert(
      0,
      ObjectiveItem(
        title: title,
        quarter: selectedQuarter.value,
        keyResults: [
          KeyResult(title: krText, progress: 0.1),
        ],
      ),
    );

    objectiveTitleController.clear();
    keyResultController.clear();

    Get.back();
    Get.snackbar('OKR Goal Created', 'New performance target added to your quarterly dashboard.', snackPosition: SnackPosition.TOP);
  }
}
