import 'package:flutter/material.dart';
import 'package:flutterapp/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Widget root do app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // Definição do tema do app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
