import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import '../../../../core/common_widgets/app_refresh_indicator.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../controller/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/clock_in_card.dart';
import '../widgets/services_grid.dart';

/// Landing page for the application providing quick access to HR services and personal metrics.
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(onTapProfile: controller.onTapProfile),
      body: AppRefreshIndicator(
        onRefresh: () async {
          await controller.refreshHomePage();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.hzSpace,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClockInCard(onToggleClockIn: controller.toggleClockIn),
              24.h,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    StringConstants.kHrAndFieldApplications,
                    style: AppTextStyle.bold17,
                  ),
                  AppText(
                    StringConstants.kAllServices,
                    style: AppTextStyle.regular12Grey,
                  ),
                ],
              ),
              12.h,
              ServicesGrid(onTapService: controller.onTapService),
              20.h,
            ],
          ),
        ),
      ),
    );
  }
}
