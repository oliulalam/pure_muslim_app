import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              onTap: () {
                print("Location Change");
              },
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Dhaka, Bangladesh",
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
                      '17-Jan-2026 | Saturday',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '3 Magh 1433 | Winter',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '28 Rajab 1447 AH',
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
                                  '02:24 AM',
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
                                  '12:44 AM',
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
                                  '04:24 PM',
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
                                  '05:45 PM',
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
                                  '06:55 PM',
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
                          '02:24 AM',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 4),
                        Text(
                          'Remaining: 05h 36m 12s',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green, // সবুজ কালার
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Next: Fajr',
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

  Future<void> getPayersTime() async {
    Uri uri = Uri.parse(
      "https://api.aladhan.com/v1/timingsByCity?city=Dhaka&country=Bangladesh&method=2",
    );

    Response response = await http.get(uri);

    if (response == 200) {}
  }
}
