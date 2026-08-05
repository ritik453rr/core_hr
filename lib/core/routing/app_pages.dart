import 'package:get/get.dart';
import '../routing/app_routes.dart';
import '../../feature/splash/splash_page.dart';
import '../../feature/splash/splash_controller.dart';
import '../../feature/auth/login_page.dart';
import '../../feature/auth/forgot_password_page.dart';
import '../../feature/auth/auth_controller.dart';
import '../../feature/dashboard/dashboard_page.dart';
import '../../feature/dashboard/dashboard_controller.dart';
import '../../feature/attendance/attendance_page.dart';
import '../../feature/attendance/attendance_controller.dart';
import '../../feature/holidays/holidays_page.dart';
import '../../feature/holidays/holidays_controller.dart';
import '../../feature/leave/leave_page.dart';
import '../../feature/leave/apply_leave_page.dart';
import '../../feature/leave/leave_controller.dart';
import '../../feature/loan/loan_page.dart';
import '../../feature/loan/apply_loan_page.dart';
import '../../feature/loan/loan_controller.dart';
import '../../feature/lead_management/lead_management_page.dart';
import '../../feature/lead_management/add_lead_page.dart';
import '../../feature/lead_management/lead_controller.dart';
import '../../feature/hr_documents/hr_documents_page.dart';
import '../../feature/hr_documents/hr_documents_controller.dart';
import '../../feature/okr/okr_page.dart';
import '../../feature/okr/add_okr_page.dart';
import '../../feature/okr/okr_controller.dart';
import '../../feature/my_team/my_team_page.dart';
import '../../feature/my_team/my_team_controller.dart';
import '../../feature/field_tracking/field_tracking_page.dart';
import '../../feature/field_tracking/field_tracking_controller.dart';
import '../../feature/profile/profile_page.dart';
import '../../feature/profile/profile_controller.dart';





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
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthController(), fenix: true)),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AuthController(), fenix: true)),
    ),


    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => DashboardController())),
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
