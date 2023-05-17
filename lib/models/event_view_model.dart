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
  final EventDao _eventDao;
  final List<Event> _events = [];
  bool _showOnlyUpcoming = false;

  MyEventsViewModel(this._eventDao) {
    // Initialize the _events list by loading data from the database
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
    await _eventDao.insertEvent(event);
    loadEvents();
  }

  void clearNewEvent() {
    _newEvent = null;
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    await _eventDao.deleteEvent(event);
    loadEvents();
  }

  void updateEvent(Event event, Event updatedEvent) async {
    // Perform the necessary database update
    await _eventDao.updateEvent(updatedEvent);

    // Optionally, update the _events list in memory
    int index = _events.indexOf(event);
    _events[index] = updatedEvent;

    loadEvents();
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

  Future<void> loadEvents() async {
    final events = await _eventDao.findAllEvents();
    _events.clear();
    _events.addAll(events);
    notifyListeners();
  }
}
