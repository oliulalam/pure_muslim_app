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

      body: Column(
        children: [
          Container(
            //height: screenHeight * 0.31,
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 230,   // ছোট ফোনের জন্য
              maxHeight: 240,   // বড় ফোনেও এর বেশি হবে না
            ),
            decoration: BoxDecoration(
              color: Color(0xFF044B77),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
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

          SizedBox(height: 20,),

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
                    offset: Offset(0, 2)
                  )
                ]
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/tajweed.png', width: 40, height: 40,),
                        SizedBox(height: 5,),
                        Text("Quran", style: TextStyle(fontSize: 16),)
                      ],
                    ),



                  ],
                ),
              ),

            ),
          )

        ],
      ),
    );
  }

  Future<void> getPayersTime() async{

    Uri uri = Uri.parse("https://api.aladhan.com/v1/timingsByCity?city=Dhaka&country=Bangladesh&method=2");

     Response response = await http.get(uri);

     if(response == 200){

     }

  }

}
