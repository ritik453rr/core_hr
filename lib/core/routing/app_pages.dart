import 'package:get/get.dart';
import '../routing/app_routes.dart';
import '../../feature/splash/splash_page.dart';
import '../../feature/splash/splash_controller.dart';
import '../../feature/login/login_page.dart';
import '../../feature/login/login_controller.dart';

/// Configures all application routes with their corresponding pages and bindings.
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SplashController())),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
    ),
  ];
}
