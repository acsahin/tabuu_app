import 'package:flutter/material.dart';
import 'package:tabuu_app/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tabuu TR'),
          ),
          body: MainScreen(),
        ),
      ),
    );
  }
}