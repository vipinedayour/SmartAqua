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

  TextEditingController textControllerS = TextEditingController();
  TextEditingController textControllerT = TextEditingController();
  TextEditingController textControllerB = TextEditingController();
  Color _currentColor = Colors.blue;
  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'singlecolor',
      'label': 'Singlecolor',
      'icon': Icon(Icons.fiber_manual_record),
    },
    {
      'value': 'cylon',
      'label': 'Cylon',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'rainbow',
      'label': 'Rainbow',
      'icon': Icon(Icons.architecture),
    },
    {
      'value': 'sinelon',
      'label': 'Sinelon',
      'icon': Icon(Icons.grade),
    },
    {
      'value': 'pacifica',
      'label': 'Pacifica',
      'icon': Icon(Icons.water),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleColorPicker(
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  initialValue: 'singlecolor',

                  icon: Icon(Icons.animation),
                  labelText: 'Animation',
                  items: _items,
                  onChanged: (val) {
                    led.child('devices').update({
                      'led_animation': val,
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    border: OutlineInputBorder(),
                    hintText: 'Servo Delay',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: TextField(
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
                            border: OutlineInputBorder(),
                            hintText: 'Top Level',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(
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
                            border: OutlineInputBorder(),
                            hintText: 'Bottom Level',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
