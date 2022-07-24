import 'package:aquarium/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:select_form_field/select_form_field.dart';

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  
   DatabaseReference led = FirebaseDatabase.instance.ref();
  
  
  final _controller = CircleColorPickerController(
    initialColor: kmaincolor,
  );

  final List<Map<String, dynamic>> _items = [
    {  
      'value': 'singlecolor',
      'label': 'Singlecolor',
      'icon': Icon(
        
        Icons.fiber_manual_record,
        color: Color.fromARGB(255, 7, 70, 75),),
    },
    {
      'value': 'cylon',
      'label': 'Cylon',
      'icon': Icon(Icons.stop,
        color: Color.fromARGB(255, 8, 85, 90)),
    },
    {
      'value': 'rainbow',
      'label': 'Rainbow',
      'icon': Icon(Icons.architecture,
        color: Color.fromARGB(255, 10, 114, 121)),
    },
    {
      'value': 'sinelon',
      'label': 'Sinelon',
      'icon': Icon(Icons.grade,
        color: Color.fromARGB(255, 15, 164, 174)),
    },
    {
      'value': 'pacifica',
      'label': 'Pacifica',
      'icon': Icon(Icons.water,
        color: kmaincolor),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
              
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SelectFormField(
                
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: 'singlecolor',
                

                icon: Icon(Icons.animation,
                color: kmaincolor,),
                labelText: 'Animation',
                items: _items,
                onChanged: (val) {
                  led.child('devices').update({
                    'led_animation': val,
                  }
                  );
                },
              ),
            ),
            
            CircleColorPicker(
                strokeWidth: 8,
                controller: _controller,
                onChanged: (color) {
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
            
            
            
            
          ],
        ),
      ),
    );
  }
}
