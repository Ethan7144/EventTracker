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
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
