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
  static const Duration _defaultDuration = Duration(milliseconds: 350);

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: _defaultDuration,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AuthController(), fenix: true),
      ),
      transition: Transition.fadeIn,
      transitionDuration: _defaultDuration,
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
      transition: Transition.fadeIn,
      transitionDuration: _defaultDuration,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _defaultDuration,
    ),
    GetPage(
      name: AppRoutes.myTeam,
      page: () => const MyTeamPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _defaultDuration,
    ),
    GetPage(
      name: AppRoutes.fieldTracking,
      page: () => const FieldTrackingPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _defaultDuration,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _defaultDuration,
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => ChangePasswordController()),
      ),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _defaultDuration,
    ),
  ];
}
