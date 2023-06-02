import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hw2/event_forms/addevent.dart';
import 'package:hw2/event_forms/editDateForm.dart';
import 'package:hw2/models/event.dart';
import 'package:provider/provider.dart';
import 'package:hw2/event_details/event_details.dart';
import 'package:hw2/dao/event_dao.dart';
import 'package:hw2/database/database.dart';
import 'package:floor/floor.dart';

class MyEventsViewModel extends ChangeNotifier {
  late final AppDatabase _database;
  List<Event> _events = [];
  bool _showOnlyUpcoming = false;

  MyEventsViewModel(this._database) {
    loadEvents();
  }

  List<Event> get eventsList => _events;
  Event getEvent(int index) => _events[index];
  int get eventsListSize => _events.length;

  Event? _newEvent;
  List<Event> get events => _showOnlyUpcoming
      ? _events.where((event) => event.endDate.isAfter(DateTime.now())).toList()
      : _events;

  bool get showOnlyUpcoming => _showOnlyUpcoming;

  set showOnlyUpcoming(bool value) {
    _showOnlyUpcoming = value;
    notifyListeners();
  }

  List<Event> getSortedEventsByStartDate() {
    _events.sort((a, b) => a.startDate.compareTo(b.startDate));
    return _events;
  }

  void addEvent(Event event) async {
    print('Adding event');
    _events.add(event);
    await _database.eventDao.insertEvent(event);
    notifyListeners();
  }

  void clearNewEvent() {
    _newEvent = null;
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    _events.remove(event);
    await _database.eventDao.deleteEvent(event);
    notifyListeners();
  }

  void updateEvent(Event event, Event updatedEvent) async {
    // Perform the necessary database update
    await _database.eventDao.updateEvent(updatedEvent);

    // Optionally, update the _events list in memory
    int index = _events.indexOf(event);
    _events[index] = updatedEvent;

    notifyListeners();
  }

  void editEventDate(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDateForm(
          event: event,
          onSave: (updatedEvent) {
            // Update the event in the database
            updateEvent(event, updatedEvent);
          },
        );
      },
    );
  }

  void showEventDetails(BuildContext context, Event event) {
    int index = _events.indexOf(event);
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Consumer<MyEventsViewModel>(
          builder: (context, viewModel, _) {
            return EventDetailsScreen(index: index);
          },
        );
      },
    ));
  }

  Future<Event?> showNewEventForm(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<MyEventsViewModel>(
          builder: (context, viewModel, _) {
            return NewEventForm(
              onSave: (event) {},
            );
          },
        );
      },
    );
  }

  void loadEvents() async {
    _events = await _database.eventDao.findAllEvents();
    if (_events.length >= 2) {
      _events.sort((a, b) => a.startDate.compareTo(b.startDate));
    }
    notifyListeners();
  }
}
