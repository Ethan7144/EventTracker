import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event.dart';
import 'addEvent.dart';
import 'editDateForm.dart';

class MyEventsPage extends StatefulWidget {
  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  List<Event> events = [];
  bool showOnlyUpcoming = false; // add a boolean flag to toggle between showing all events and only upcoming events

  void _showNewEventForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEventForm(
          onSave: (event) {
            setState(() {
              events.add(event); // Add the new event to the events list
            });
          },
        );
      },
    );
  }

  void _handleSaveEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  void _showEditDateForm(Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDateForm(
          event: event,
          onSave: (updatedEvent) {
            setState(() {
              int index = events.indexOf(event);
              events[index].startDate = updatedEvent.startDate;
              events[index].endDate = updatedEvent.endDate;
            });
          },
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final now = DateTime.now();
    final upcomingEvents = events.where((event) => event.endDate.isAfter(now)).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: showOnlyUpcoming ? upcomingEvents.length : events.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = showOnlyUpcoming ? upcomingEvents[index] : events[index];

                  return InkWell(
                    onTap: () {
                      _showEditDateForm(event);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat.yMMMd().add_jm().format(event.startDate)} - ${DateFormat.yMMMd().add_jm().format(event.endDate)}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              events.remove(event);
                            });
                          },
                          child: Text('Delete'),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Add Event'),
              onPressed: _showNewEventForm,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: showOnlyUpcoming,
                  onChanged: (value) {
                    setState(() {
                      showOnlyUpcoming = value!;
                    });
                  },
                ),
                Text('Show only upcoming events'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
