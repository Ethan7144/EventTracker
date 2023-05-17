// dao/event_dao.dart
import 'package:floor/floor.dart';
import 'package:hw2/models/event.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvents();

  @Query('SELECT title FROM Event')
  Stream<List<String>> findAllTitles();

  @Query('SELECT * FROM Person WHERE title = :title')
  Stream<Event?> findEventbyTitle(String title);

  @insert
  Future<void> insertEvent(Event event);

  @delete
  Future<void> deleteEvent(Event event);

  @update
  Future<void> updateEvent(Event event);



}