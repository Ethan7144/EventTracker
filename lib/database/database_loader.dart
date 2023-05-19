import 'dart:io';
import 'package:floor/floor.dart';
import 'package:hw2/database/database.dart';

Future<AppDatabase> loadDatabase() {
  return $FloorAppDatabase.databaseBuilder('event_database.db').build();
}