import 'package:aquarium/screens/colorpicker.dart';
import 'package:aquarium/screens/analytics.dart';
import 'package:aquarium/screens/homepage.dart';
import 'package:aquarium/utilities/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final screens = [HomePage(), Analytics(), ColorPicker()];
  final items = [
    Icon(Icons.home),
    Icon(Icons.data_object),
    Icon(Icons.settings),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEBF3FE),
        primaryColor: kmaincolor,
      ),
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: kmaincolor)),
          child: CurvedNavigationBar(
            items: items,
            index: index,
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
            height: 50,
            backgroundColor: Colors.transparent,
            color: ksecondarycolor,
            buttonBackgroundColor: ksecondarycolor,
            animationDuration: Duration(milliseconds: 400),
          ),
        ),
        body: IndexedStack(
          index: index,
          children: screens,
        ),
      ),
    );
  }
}
