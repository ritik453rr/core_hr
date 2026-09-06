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
import '../../feature/attendance/presentation/page/attendance_page.dart';
import '../../feature/attendance/presentation/controller/attendance_controller.dart';
import '../../feature/holidays/presentation/page/holidays_page.dart';
import '../../feature/holidays/presentation/controller/holidays_controller.dart';
import '../../feature/leave/presentation/page/leave_page.dart';
import '../../feature/leave/presentation/page/apply_leave_page.dart';
import '../../feature/leave/presentation/controller/leave_controller.dart';
import '../../feature/loan/presentation/page/loan_page.dart';
import '../../feature/loan/presentation/page/apply_loan_page.dart';
import '../../feature/loan/presentation/controller/loan_controller.dart';
import '../../feature/lead_management/presentation/page/lead_management_page.dart';
import '../../feature/lead_management/presentation/page/add_lead_page.dart';
import '../../feature/lead_management/presentation/controller/lead_controller.dart';
import '../../feature/hr_documents/presentation/page/hr_documents_page.dart';
import '../../feature/hr_documents/presentation/controller/hr_documents_controller.dart';
import '../../feature/okr/presentation/page/okr_page.dart';
import '../../feature/okr/presentation/page/add_okr_page.dart';
import '../../feature/okr/presentation/controller/okr_controller.dart';
import '../../feature/my_team/presentation/page/my_team_page.dart';
import '../../feature/my_team/presentation/controller/my_team_controller.dart';
import '../../feature/field_tracking/presentation/page/field_tracking_page.dart';
import '../../feature/field_tracking/presentation/controller/field_tracking_controller.dart';
import '../../feature/profile/presentation/page/profile_page.dart';
import '../../feature/profile/presentation/controller/profile_controller.dart';





/// Configures all application routes with their corresponding pages and bindings.
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SplashController())),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthController(), fenix: true)),
    ),


    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DashboardController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.lazyPut(() => AttendanceController(), fenix: true);
        Get.lazyPut(() => FieldTrackingController(), fenix: true);
        Get.lazyPut(() => MyTeamController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => HomeController())),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => const AttendancePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AttendanceController())),
    ),
    GetPage(
      name: AppRoutes.holidays,
      page: () => const HolidaysPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => HolidaysController())),
    ),
    GetPage(
      name: AppRoutes.leave,
      page: () => const LeavePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LeaveController())),
    ),
    GetPage(
      name: AppRoutes.applyLeave,
      page: () => const ApplyLeavePage(),
    ),
    GetPage(
      name: AppRoutes.loan,
      page: () => const LoanPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoanController())),
    ),
    GetPage(
      name: AppRoutes.applyLoan,
      page: () => const ApplyLoanPage(),
    ),
    GetPage(
      name: AppRoutes.leadManagement,
      page: () => const LeadManagementPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LeadController())),
    ),
    GetPage(
      name: AppRoutes.addLead,
      page: () => const AddLeadPage(),
    ),
    GetPage(
      name: AppRoutes.hrDocuments,
      page: () => const HrDocumentsPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => HrDocumentsController())),
    ),
    GetPage(
      name: AppRoutes.okr,
      page: () => const OkrPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OkrController())),
    ),
    GetPage(
      name: AppRoutes.addOkr,
      page: () => const AddOkrPage(),
    ),
    GetPage(
      name: AppRoutes.myTeam,
      page: () => const MyTeamPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => MyTeamController())),
    ),
    GetPage(
      name: AppRoutes.fieldTracking,
      page: () => const FieldTrackingPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => FieldTrackingController())),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ProfileController())),
    ),
  ];

}
