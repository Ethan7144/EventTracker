import 'package:flutter/material.dart';
import 'package:hw2/dao/event_dao.dart';
import 'package:provider/provider.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';
import 'package:provider/provider.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/database/database.dart';



class MyApp extends StatelessWidget {
  final AppDatabase database;
  const MyApp({super.key, required this.database});
  @override
  Widget build(BuildContext context) {
          return ChangeNotifierProvider(
            create: (context) => MyEventsViewModel(database),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                primaryColor: Colors.lightBlue,
                textTheme: const TextTheme(
                  displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                  titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
                  displaySmall: TextStyle(fontSize: 20),
                ),
              ),
              routerConfig: router,
            ),
          );
        } 
      }

