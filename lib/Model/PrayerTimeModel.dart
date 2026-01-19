class PrayerTimeModel {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String readableDate;
  final String hijriDate;

  PrayerTimeModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.readableDate,
    required this.hijriDate,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final timings = data['timings'];
    final date = data['date'];

    return PrayerTimeModel(
      fajr: timings['Fajr'],
      dhuhr: timings['Dhuhr'],
      asr: timings['Asr'],
      maghrib: timings['Maghrib'],
      isha: timings['Isha'],
      readableDate: date['readable'],
      hijriDate: date['hijri']['date'],
    );
  }
}
