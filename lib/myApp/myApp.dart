import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyEventsViewModel(),
      child: MaterialApp.router(
        title: 'My Events App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.lightBlue,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
            titleLarge:  TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
            displaySmall: TextStyle(fontSize: 20),
          )
        ),
        routerConfig: router,
      ),
    );
  }
}
