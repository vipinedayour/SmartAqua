import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController textController = TextEditingController();
  DatabaseReference led = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Icon(
            Icons.settings,
            size: 50,
          ),
          Container(
            width: 300,
            child: TextField(
              onEditingComplete: () {
                print(textController.text);
                int delay = int.parse(textController.text);
                led.child('devices').update({
                  'servo_delay': delay,
                });
              },
              keyboardType: TextInputType.number,
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'servo delay',
              ),
            ),
          )
        ],
      ),
    );
  }
}
