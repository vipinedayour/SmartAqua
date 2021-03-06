import 'package:aquarium/utilities/constants.dart';
import 'package:aquarium/widgets/clock.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  DatabaseReference led = FirebaseDatabase.instance.ref();
  TextEditingController textControllerS = TextEditingController();
  String _scheduledTime = "";
  bool feed = false;

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.dark(
            primary: kmaincolor,
          )),
          child: child!,
        );
      },
    ).then(
      (value) {
        setState(() {
          String time = value!.format(context).toString();
          if (time[1] == ":") {
            _scheduledTime = "0$time";
          } else {
            _scheduledTime = time;
          }
          database.child('devices').update({
            'scheduled_time': _scheduledTime,
          });
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    database.child('devices').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      if (mounted) {
        setState(() {
          _scheduledTime = (data as Map)['scheduled_time'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       
        children:[ Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
            Clock(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                onPressed: () async {
                  database.child('devices').update({
                    'servo_status': true,
                  });
                  await Future.delayed(Duration(milliseconds: 1000));
                  setState(() => feed = true);
                  await Future.delayed(Duration(milliseconds: 1500));
                  setState(() => feed = false);
                  print('feeded');
                },
                child: feed
                    ? Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          Text(
                            'FEEDED',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : Text("FEED NOW"),
                style: TextButton.styleFrom(
                    primary: kmaincolor,
                    backgroundColor: feed ? Colors.green : Colors.white,
                    textStyle: TextStyle(fontSize: 20)),
              ),
              TextButton(
                onPressed: _showTimePicker,
                child: Text("SCHEDULE"),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: kmaincolor,
                    textStyle: TextStyle(fontSize: 20)),
              )
            ]),
            
          Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: Text(
              "Scheduled Time : $_scheduledTime",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          
                
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left:40,right:40),
          child: TextField(
                    onEditingComplete: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
              
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      print(textControllerS.text);
                      int delay = int.tryParse(textControllerS.text) ?? 700;
              
                      led.child('devices').update({
                        'servo_delay': delay,
                      });
                    },
                    keyboardType: TextInputType.number,
                    controller: textControllerS,
                   
                     decoration: InputDecoration(
                        fillColor:  Color.fromARGB(255, 214, 246, 255),
                        labelText:'Servo Delay' ,
                        hintStyle: TextStyle(color: Color.fromARGB(170, 0, 0, 0)),
                        hintText: 'Servo Delay',
                      
                      iconColor:ksecondarycolor ,
                      focusColor: ksecondarycolor,
                      
                      ),
                    
                    ),
        ),]
      ),
    );
  }
}
