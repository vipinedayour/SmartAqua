import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  DatabaseReference led = FirebaseDatabase.instance.ref();

  TextEditingController textController = TextEditingController();
  Color _currentColor = Colors.blue;
  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleColorPicker(
              strokeWidth: 8,
              controller: _controller,
              onChanged: (color) {
                setState(() => _currentColor = color);
                print('RGB(${color.red},${color.green},${color.blue})');
                led.child('devices').update({
                  'rgb': '${color.red},${color.green},${color.blue}',
                });
              },
              colorCodeBuilder: (context, color) {
                return Text(
                  'RGB(${color.red},${color.green},${color.blue})',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              },
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
      ),
    );
  }
}
