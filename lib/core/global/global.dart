import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../common_widgets/app_toast.dart';
import '../language/string_constants.dart';

/// Provides global utility functions used across the application.
class Global {
  static final connectivity = Connectivity();

  /// Checks internet connectivity, updates state, and optionally shows an error message.
  static Future<bool> checkInternet({bool showMsg = true}) async {
    final results = await connectivity.checkConnectivity();
    final isConnected = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (isConnected) {
      return true;
    } else {
      if (showMsg) {
        AppToast.showToast(
          message: StringConstants.kCheckInternetConnection.tr,
        );
      }
      return false;
    }
  }
}
