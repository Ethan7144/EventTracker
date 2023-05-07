import 'package:flutter/material.dart';
import 'package:hw2/event_forms/addevent.dart';
import 'package:hw2/event_forms/editDateForm.dart';
import 'package:hw2/models/event.dart';
import 'package:provider/provider.dart';
import 'package:hw2/event_details/event_details.dart';

class MyEventsViewModel extends ChangeNotifier {
  final List<Event> _events = [];
  bool _showOnlyUpcoming = false;

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

  

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void clearNewEvent() {
    _newEvent = null;
    notifyListeners();
  }

  void updateEvent(Event event, Event updatedEvent) {
    int index = _events.indexOf(event);
    if (index >= 0) {
      _events[index].startDate = updatedEvent.startDate;
      _events[index].endDate = updatedEvent.endDate;
      notifyListeners();
    }
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void editEventDate(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDateForm(
          event: event,
          onSave: (updatedEvent) {
            int index = _events.indexOf(event);
            _events[index].startDate = updatedEvent.startDate;
            _events[index].endDate = updatedEvent.endDate;
            notifyListeners();
          },
        );
      },
    );
  }

  void showEventDetails(BuildContext context, Event event) {
    int index = _events.indexOf(event);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Consumer<MyEventsViewModel>(
          builder: (context, viewModel, _) {
          return EventDetailsScreen(index: index);
        },
      );
        },
      )
    );
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
}
