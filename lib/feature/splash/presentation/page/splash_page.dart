import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/splash_controller.dart';
import '../widgets/splash_logo_widget.dart';

/// Initial entry screen of the app displaying branding and handling initialization.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.c0F172A,
              AppColors.c1E3A8A,
              AppColors.c0284C7,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppSafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 40),

              // Middle Logo and Branding
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Container with glowing effect & subtle border
                  const SplashLogoWidget(),
                  const SizedBox(height: 28),

                  // App Title
                  const Text(
                    StringConstants.kAppTitle,
                    style: AppTextStyle.bold32White,
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Text(
                      StringConstants.kAppSubtitle,
                      style: AppTextStyle.medium13Blue,
                    ),
                  ),
                ],
              ),

              // Bottom Loading Indicator & Version Footer
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: AppLoadingIndicator(
                        color: AppColors.c38BDF8,
                        strokeWidth: 2.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      StringConstants.kAppVersionFooter,
                      style: AppTextStyle.regular11White60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
