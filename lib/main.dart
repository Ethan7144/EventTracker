import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'events/displayEvent.dart';
import 'package:hw2/models/event_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyEventsViewModel(),
      child: MaterialApp(
        title: 'My Events App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyEventsPage(),
      ),
    );
  }
}
