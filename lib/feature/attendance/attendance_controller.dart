import 'package:get/get.dart';

class AttendanceRecord {
  final String date;
  final String clockIn;
  final String clockOut;
  final String duration;
  final String location;
  final String status;

  AttendanceRecord({
    required this.date,
    required this.clockIn,
    required this.clockOut,
    required this.duration,
    required this.location,
    required this.status,
  });
}

class AttendanceController extends GetxController {
  var isClockedIn = false.obs;
  var currentAddress = 'Headquarters - 100 Tech Way, San Francisco, CA'.obs;
  var currentLatLong = '37.7749° N, 122.4194° W'.obs;
  var todayClockIn = '--:--'.obs;
  var todayClockOut = '--:--'.obs;

  var attendanceList = <AttendanceRecord>[
    AttendanceRecord(
      date: 'Aug 05, 2026',
      clockIn: '09:02 AM',
      clockOut: '06:15 PM',
      duration: '9h 13m',
      location: '100 Tech Way, SF',
      status: 'On Time',
    ),
    AttendanceRecord(
      date: 'Aug 04, 2026',
      clockIn: '09:14 AM',
      clockOut: '06:05 PM',
      duration: '8h 51m',
      location: 'Field Client Office, Oakland',
      status: 'On Time',
    ),
    AttendanceRecord(
      date: 'Aug 03, 2026',
      clockIn: '09:45 AM',
      clockOut: '06:30 PM',
      duration: '8h 45m',
      location: 'Remote Work',
      status: 'Late',
    ),
    AttendanceRecord(
      date: 'Aug 01, 2026',
      clockIn: '08:55 AM',
      clockOut: '05:45 PM',
      duration: '8h 50m',
      location: '100 Tech Way, SF',
      status: 'On Time',
    ),
  ].obs;

  void toggleAttendance() {
    isClockedIn.value = !isClockedIn.value;
    final now = DateTime.now();
    final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    if (isClockedIn.value) {
      todayClockIn.value = timeStr;
      todayClockOut.value = '--:--';
      Get.snackbar('Clock-in Recorded', 'Location captured: ${currentAddress.value}', snackPosition: SnackPosition.TOP);
    } else {
      todayClockOut.value = timeStr;
      attendanceList.insert(
        0,
        AttendanceRecord(
          date: 'Aug 05, 2026',
          clockIn: todayClockIn.value,
          clockOut: todayClockOut.value,
          duration: '8h 30m',
          location: currentAddress.value,
          status: 'On Time',
        ),
      );
      Get.snackbar('Clock-out Recorded', 'Work session successfully logged.', snackPosition: SnackPosition.TOP);
    }
  }
}
