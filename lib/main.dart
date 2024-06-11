import 'package:flutter/material.dart';
import 'package:weatherflutterproject/screens/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.greenAccent,
        useMaterial3: false
      ),
      home: Loading(),
    );
  }
}