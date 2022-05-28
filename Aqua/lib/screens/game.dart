import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  dynamic temperature = 25;
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();
    database.child('devices').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (mounted) {
        setState(() {
          temperature = (data as Map)['temperature'];
        });
      }
    });

    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 246, 255),
      body: Stack(
        children: [
          // Center(
          //   child: Text('Water Quality',
          //       style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //         wordSpacing: 1,
          //         color: Color.fromARGB(255, 17, 33, 79),
          //       ),
          //       textScaleFactor: 3.5),
          // ),
          CustomPaint(
            painter: MyPainter(
              firstAnimation.value,
              secondAnimation.value,
              thirdAnimation.value,
              fourthAnimation.value,
            ),
            child: SizedBox(
              height: size.height,
              width: size.width,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                //   CircularPercentIndicator(
                //     radius: 60.0,
                //     backgroundColor: Color.fromARGB(255, 42, 56, 95),
                //     progressColor: Color(0xff24c7cb),
                //     animation: false,
                //     animationDuration: 1200,
                //     lineWidth: 10.0,
                //     percent: temperature.round() / 100,
                //     center: new Text(
                //       "220\n PPM",
                //       style: new TextStyle(
                //           fontWeight: FontWeight.bold, fontSize: 30),
                //     ),
                //   ),
                CircularPercentIndicator(
                  radius: 60.0,
                  animation: false,
                  backgroundColor: Color.fromARGB(255, 4, 15, 46),
                  progressColor: Color(0xff24c7cb),
                  animationDuration: 1200,
                  lineWidth: 10.0,
                  percent: 0.4,
                  center: new Text(
                    temperature.round().toString() + "°C",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                )
              ],
              //   ),
              //   CircularPercentIndicator(
              //     radius: 80.0,
              //     animation: false,
              //     backgroundColor: Color.fromARGB(255, 59, 152, 154),
              //     progressColor: Color.fromARGB(255, 4, 15, 46),
              //     animationDuration: 1200,
              //     lineWidth: 15.0,
              //     percent: 0.4,
              //     center: new Text(
              //       "Good",
              //       style:
              //           new TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              //     ),
              //   ),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff24c7cb).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
