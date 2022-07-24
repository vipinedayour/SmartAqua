import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aquarium/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'colorpicker.dart';


class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> with TickerProviderStateMixin {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  DatabaseReference led = FirebaseDatabase.instance.ref();
  TextEditingController textControllerT = TextEditingController();
  TextEditingController textControllerB = TextEditingController();
  dynamic temperature = 25;
  dynamic tds = 100;
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
          tds = data['tds'];
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
    Future openDialogue() => showDialog(
        context: context,
        builder: (content) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                actionsPadding: EdgeInsets.all(12),
                backgroundColor: Color.fromARGB(96, 0, 0, 0),
                title: Text(
                  "Are you sure?",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: kmaincolor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(186, 36, 200, 203),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Color.fromARGB(255, 0, 0, 0),
                        ),
                        onPressed: () {
                          database.child('devices').update({
                            'refill': true,
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Yes'),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1.0),
                        color: Color.fromARGB(0, 26, 34, 126),
                      ),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No')),
                    ),
                  )
                ]));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 246, 255),
      body: Stack(
        children: [
          
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
          Column(
            
            children: [
              Padding(
                padding: EdgeInsets.only(top:60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularPercentIndicator(
                      radius: 60.0,
                      animation: false,
                      backgroundColor: ksecondarycolor,
                      progressColor: kmaincolor,
                      animationDuration: 1200,
                      lineWidth: 15,
                      percent: temperature/100,
                      
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text(
                        temperature.round().toString() + "°C",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
              
                    CircularPercentIndicator(
                      radius: 60.0,
                      animation: false,
                      backgroundColor: ksecondarycolor,
                      progressColor: kmaincolor,
                      animationDuration: 1200,
                      lineWidth: 15,
                      percent: tds/200,
                      
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text(
                        tds.round().toString() + "\nPPM",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:40,right:40),
                  child: Column(
                    
                    children: [
                      TextField(
                        
                        onEditingComplete: () {
                          FocusScopeNode currentFocus =
                              FocusScope.of(context);
                      
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          print(textControllerT.text);
                          int topLevel =
                              int.tryParse(textControllerT.text) ?? 3;
                      
                          led.child('devices').update({
                            'top_level': topLevel,
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: textControllerT,
                        decoration: InputDecoration(
                          fillColor:  Color.fromARGB(255, 214, 246, 255),
                          
                          hintText: 'Water level',
                          labelText:'Top Level' ,
                          hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))
                        ),
                        
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      TextField(
                    onEditingComplete: () {
                      FocusScopeNode currentFocus =
                          FocusScope.of(context);
              
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      print(textControllerB.text);
                      int bottomLevel =
                          int.tryParse(textControllerB.text) ?? 13;
              
                      led.child('devices').update({
                        'bottom_level': bottomLevel,
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: textControllerB,
                    decoration: InputDecoration(
                      fillColor:  Color.fromARGB(255, 214, 246, 255),
                      labelText:'Bottom Level' ,
                      hintStyle: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),
                      hintText: ' Water Level',
                    ),
                  ),
                  SizedBox(
                        height: 60,
                  ),
                  TextButton(
                onPressed: () {
                  openDialogue();
                },
                child: Text("CLEANUP"),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: ksecondarycolor,
                    textStyle: TextStyle(fontSize: 20)),
              )
                    ],
                  ),
                ),
              ),
              
              
            ],
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
