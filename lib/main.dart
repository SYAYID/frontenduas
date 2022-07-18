import 'package:flutter/material.dart';
import 'package:cruduas3/utils/contants.dart';
import 'package:cruduas3/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'crud UAS Pemob',
        theme: ThemeData(
          accentColor: primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}