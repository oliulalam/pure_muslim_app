import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF044B77),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Pure Muslim", style: TextStyle(color: Colors.white),),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white,),
                SizedBox(width: 5,),
                Text("Dhaka, Bangladesh", style: TextStyle(fontSize: 18, color: Colors.white),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
