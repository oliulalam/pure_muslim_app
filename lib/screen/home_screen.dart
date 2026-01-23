import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Model/PrayerTimeModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String cityName = "Loading...";
  String countryName = "";
  PrayerTimeModel? prayerModel;

  Timer? _timer;
  String remainingTime = "00:00:00";
  String nextPrayerName = "Loading...";
  double progressValue = 0.0;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationManually();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  Future<void> requestLocationManually() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      await getLocationAndLoadData();
    } else {
      await loadPrayerByCityFallback();
    }
  }


  Future<void> getLocationAndLoadData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await loadPrayerByCityFallback();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await loadPrayerByCityFallback();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    cityName = placemarks.first.locality ?? "Unknown";
    countryName = placemarks.first.country ?? "";

    await getPrayerTimeByLocation(
      position.latitude,
      position.longitude,
    );

    setState(() {});
  }

  Future<void> getPrayerTimeByLocation(double lat, double lon) async {
    Uri uri = Uri.parse(
      "https://api.aladhan.com/v1/timings"
          "?latitude=$lat&longitude=$lon&method=2",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        prayerModel = PrayerTimeModel.fromJson(jsonDecode(response.body)['data']);
        startTimer();
      });
    }
  }


  Future<void> loadPrayerByCityFallback() async {
    Uri uri = Uri.parse(
      "https://api.aladhan.com/v1/timingsByCity"
          "?city=Dhaka&country=Bangladesh&method=2",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {

      setState(() {
        prayerModel = PrayerTimeModel.fromJson(jsonDecode(response.body)["data"]);
        cityName = "Dhaka";
        countryName = "Bangladesh";
        startTimer();
      });
    }
  }


  void startTimer() {
    _timer?.cancel(); // আগের টাইমার থাকলে বন্ধ করবে
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (prayerModel == null) return;

      DateTime now = DateTime.now();

      Map<String, DateTime> prayerTimes = {
        "Fajr": _parseTime(prayerModel!.fajr),
        "Dhuhr": _parseTime(prayerModel!.dhuhr),
        "Asr": _parseTime(prayerModel!.asr),
        "Maghrib": _parseTime(prayerModel!.maghrib),
        "Isha": _parseTime(prayerModel!.isha),
      };

      String next = "Fajr";
      DateTime nextTime = prayerTimes["Fajr"]!.add(const Duration(days: 1));

      for (var entry in prayerTimes.entries) {
        if (entry.value.isAfter(now)) {
          next = entry.key;
          nextTime = entry.value;
          break;
        }
      }

      Duration diff = nextTime.difference(now);

      if (mounted) {
        setState(() {
          nextPrayerName = next;
          remainingTime = "${diff.inHours.toString().padLeft(2, '0')}h "
              "${(diff.inMinutes % 60).toString().padLeft(2, '0')}m "
              "${(diff.inSeconds % 60).toString().padLeft(2, '0')}s";

          // প্রগ্রেস বার ভ্যালু (এটি ০.০ থেকে ১.০ এর মধ্যে থাকতে হয়)
          progressValue = (diff.inMinutes / 600).clamp(0.0, 1.0);
        });
      }
    });
  }

  DateTime _parseTime(String time) {
    DateFormat format = DateFormat("hh:mm a");
    DateTime temp = format.parse(time);
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, temp.hour, temp.minute);
  }

  //Bangla Date






  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF044B77),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pure Muslim",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
            GestureDetector(
              onTap: () async {
                await requestLocationManually();
              },
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                      "$cityName, $countryName",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //height: screenHeight * 0.31,
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 230, // ছোট ফোনের জন্য
                maxHeight: 240, // বড় ফোনেও এর বেশি হবে না
              ),
              decoration: BoxDecoration(
                color: Color(0xFF044B77),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${prayerModel!.readableDate} | ${prayerModel!.weekday}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      getBanglaFullDateInEnglish(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${prayerModel!.hijriDay} ${prayerModel!.hijriMonth} ${prayerModel!.hijriYear} AH",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Fajor',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Icon(
                                  Icons.wb_cloudy,
                                  color: Color(0xFF81D4FA),
                                  size: 28,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  prayerModel!.fajr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Dhuhr',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Icon(
                                  Icons.wb_sunny,
                                  color: Color(0xFFFFD600),
                                  size: 28,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  prayerModel!.dhuhr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Asr',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Icon(
                                  Icons.cloud_queue,
                                  color: Color(0xFFFFB300),
                                  size: 28,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  prayerModel!.asr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Maghrib',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Icon(
                                  Icons.wb_twilight,
                                  color: Color(0xFFFFAB40),
                                  size: 28,
                                ),
                                SizedBox(height: 5),
                                Text(
                                   prayerModel!.maghrib,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Isha',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Icon(
                                  Icons.nightlight_round,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  prayerModel!.isha,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/tajweed.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(height: 5),
                          Text("Quran", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/kaba.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(height: 5),
                          Text("Qibla", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/allah.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(height: 5),
                          Text("Allah", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/unnamedd.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(height: 5),
                          Text("Allah", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            Container(
              height: 120,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.amberAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: CircularProgressIndicator(
                          value: 0.7,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 25),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                        DateFormat('hh:mm a').format(DateTime.now()),

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 4),
                        Text(
                          'Remaining: $remainingTime',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green, // সবুজ কালার
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Next: $nextPrayerName',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black54, width: 2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sehri & Ifter",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          "Forbidden Times",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("2:00 AM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                              Text("Sehri ends", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("2:34 PM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                              Text("Ifter ends", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sunrise", style: TextStyle( fontSize: 11, fontWeight: FontWeight.w600),),
                                    Text('03:34 AM - 03:58 AM', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w600),)
                                  ],
                                ),
                              ),
                              Divider(height: 1,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Noon", style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600),),
                                    Text('03:34 AM - 03:58 AM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),)
                                  ],
                                ),
                              ),
                              Divider(height: 1,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sunset", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),),
                                    Text('03:34 AM - 03:58 AM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )

                  // Column end
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
