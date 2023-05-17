import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/dao/event_dao.dart';
import 'package:hw2/dateTimeConverter/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Event])
@TypeConverters([DateTimeConverter]) // Apply the DateTimeConverter
abstract class AppDatabase extends FloorDatabase {
  EventDao get eventDao;
  static Future<AppDatabase> createDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('event_database.db').build();
    return database;
  }
}
