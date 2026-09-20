import 'package:get/get.dart';
import '../routing/app_routes.dart';
import '../../feature/splash/presentation/page/splash_page.dart';
import '../../feature/splash/presentation/controller/splash_controller.dart';
import '../../feature/auth/presentation/page/login_page.dart';
import '../../feature/auth/presentation/controller/auth_controller.dart';
import '../../feature/dashboard/presentation/page/dashboard_page.dart';
import '../../feature/dashboard/presentation/controller/dashboard_controller.dart';
import '../../feature/home/presentation/page/home_page.dart';
import '../../feature/home/presentation/controller/home_controller.dart';
import '../../feature/my_team/presentation/page/my_team_page.dart';
import '../../feature/my_team/presentation/controller/my_team_controller.dart';
import '../../feature/field_tracking/presentation/page/field_tracking_page.dart';
import '../../feature/field_tracking/presentation/controller/field_tracking_controller.dart';
import '../../feature/profile/presentation/page/profile_page.dart';
import '../../feature/profile/presentation/controller/profile_controller.dart';
import '../../feature/change_password/presentation/page/change_password_page.dart';
import '../../feature/change_password/presentation/controller/change_password_controller.dart';

/// Configures all application routes with their corresponding pages and bindings.
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AuthController(), fenix: true),
      ),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DashboardController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.lazyPut(() => FieldTrackingController(), fenix: true);
        Get.lazyPut(() => MyTeamController(), fenix: true);
        Get.put(ProfileController(), permanent: true);
      }),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.myTeam, page: () => const MyTeamPage()),
    GetPage(
      name: AppRoutes.fieldTracking,
      page: () => const FieldTrackingPage(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => ChangePasswordController()),
      ),
    ),
  ];
}
