import 'package:get/get.dart';

class HolidayItem {
  final String title;
  final String date;
  final String day;
  final String type; // Public, Optional, Corporate Event
  final String description;

  HolidayItem({
    required this.title,
    required this.date,
    required this.day,
    required this.type,
    required this.description,
  });
}

class HolidaysController extends GetxController {
  static const String holidaysId = 'holidays';

  String selectedTab = 'All';

  List<HolidayItem> holidays = <HolidayItem>[
    HolidayItem(
      title: 'Independence Day',
      date: 'Aug 15, 2026',
      day: 'Saturday',
      type: 'Public',
      description: 'National public holiday celebrating Independence Day.',
    ),
    HolidayItem(
      title: 'Annual Tech Summit 2026',
      date: 'Sep 10, 2026',
      day: 'Thursday',
      type: 'Corporate Event',
      description: 'Company-wide technology showcase and hackathon.',
    ),
    HolidayItem(
      title: 'Labor Day',
      date: 'Sep 07, 2026',
      day: 'Monday',
      type: 'Public',
      description: 'Public holiday recognizing labor movement achievements.',
    ),
    HolidayItem(
      title: 'Company Foundation Day',
      date: 'Oct 24, 2026',
      day: 'Saturday',
      type: 'Corporate Event',
      description: 'Annual corporate celebration and gala dinner.',
    ),
    HolidayItem(
      title: 'Diwali / Festival of Lights',
      date: 'Nov 01, 2026',
      day: 'Sunday',
      type: 'Public',
      description: 'Festival celebration for team members.',
    ),
    HolidayItem(
      title: 'Thanksgiving Day',
      date: 'Nov 26, 2026',
      day: 'Thursday',
      type: 'Optional',
      description: 'Optional holiday for eligible employees.',
    ),
  ];

  List<HolidayItem> get filteredHolidays {
    if (selectedTab == 'All') return holidays;
    return holidays.where((h) => h.type.toLowerCase() == selectedTab.toLowerCase()).toList();
  }

  void setTab(String tab) {
    selectedTab = tab;
    update([holidaysId]);
  }
}
