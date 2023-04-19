import 'package:flutter/material.dart';
import 'events/displayEvent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Events'),
        ),
        body: MyEventsPage(),
      ),
    );
  }
}
