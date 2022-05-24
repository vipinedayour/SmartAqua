import 'package:aquarium/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  DatabaseReference led = FirebaseDatabase.instance.ref();
  double temperature = 25;

  @override
  void initState() {
    super.initState();

    led.child('devices').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (mounted) {
        setState(() {
          temperature = (data as Map)['temperature'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                radius: 80.0,
                animation: false,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: temperature.round() / 100,
                center: new Text(
                  temperature.round().toString() + "°C",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.white,
                progressColor: kmaincolor,
              ),
              CircularPercentIndicator(
                radius: 80.0,
                animation: false,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: 0.5,
                center: new Text(
                  "220\n PPM",
                  style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.white,
                progressColor: kmaincolor,
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 80.0,
            animation: false,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: 0.8,
            center: new Text(
              "Good",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: Colors.white,
            progressColor: kmaincolor,
          ),
        ],
      ),
    );
  }
}
