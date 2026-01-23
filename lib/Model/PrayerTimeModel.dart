import 'package:intl/intl.dart';

class PrayerTimeModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  // তারিখ ও বারের ভেরিয়েবলগুলো
  final String readableDate;  // 24 Jan 2026
  final String weekday;       // Saturday
  final String hijriDay;      // 5
  final String hijriMonth;    // Shaʿbān
  final String hijriYear;     // 1447

  PrayerTimeModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.readableDate,
    required this.weekday, // নতুন
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriYear,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    final timings = json['timings'];
    final dateObj = json['date'];
    final gregorianObj = dateObj['gregorian']; // গ্রিগোরিয়ান অবজেক্ট এক্সেস করলাম
    final hijriObj = dateObj['hijri'];

    // সময় কনভার্ট করার ফাংশন
    String convertTo12Hour(String time) {
      DateTime tempDate = DateFormat("HH:mm").parse(time);
      return DateFormat("hh:mm a").format(tempDate);
    }

    return PrayerTimeModel(
      fajr: convertTo12Hour(timings['Fajr']),
      sunrise: convertTo12Hour(timings['Sunrise']),
      dhuhr: convertTo12Hour(timings['Dhuhr']),
      asr: convertTo12Hour(timings['Asr']),
      maghrib: convertTo12Hour(timings['Maghrib']),
      isha: convertTo12Hour(timings['Isha']),

      readableDate: dateObj['readable'] ?? "",
      weekday: gregorianObj['weekday']['en'] ?? "", // Saturday যোগ করা হলো
      hijriDay: hijriObj['day'] ?? "",
      hijriMonth: hijriObj['month']['en'] ?? "",
      hijriYear: hijriObj['year'] ?? "",
    );
  }
}