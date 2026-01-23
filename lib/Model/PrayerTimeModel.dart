import 'package:intl/intl.dart';

class PrayerTimeModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTimeModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    final timings = json['timings'];

    // সময় কনভার্ট করার ফাংশন
    String convertTo12Hour(String time) {
      // API থেকে আসা সময় সাধারণত "HH:mm" ফরম্যাটে থাকে
      DateTime tempDate = DateFormat("HH:mm").parse(time);
      return DateFormat("hh:mm a").format(tempDate); // এটি "05:30 PM" ফরম্যাটে দিবে
    }

    return PrayerTimeModel(
      fajr: convertTo12Hour(timings['Fajr']),
      sunrise: convertTo12Hour(timings['Sunrise']),
      dhuhr: convertTo12Hour(timings['Dhuhr']),
      asr: convertTo12Hour(timings['Asr']),
      maghrib: convertTo12Hour(timings['Maghrib']),
      isha: convertTo12Hour(timings['Isha']),
    );
  }
}