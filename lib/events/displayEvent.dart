import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'addEvent.dart';
import 'editDateForm.dart';
import 'event.dart';
import 'package:hw2/models/event_view_model.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventsModel = Provider.of<MyEventsViewModel>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: Consumer<MyEventsViewModel>(
                builder: (context, eventsModel, child) {
                  final now = DateTime.now();
                  final upcomingEvents = eventsModel.events
                      .where((event) => event.endDate.isAfter(now))
                      .toList();

                  return ListView.builder(
                    itemCount: eventsModel.showOnlyUpcoming
                        ? upcomingEvents.length
                        : eventsModel.events.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = eventsModel.showOnlyUpcoming
                          ? upcomingEvents[index]
                          : eventsModel.events[index];

                      return InkWell(
                        onTap: () {
                          _showEditDateForm(context, eventsModel, event);
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
                                eventsModel.deleteEvent(event);
                              },
                              child: Text('Delete'),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Add Event'),
              onPressed: () => _showNewEventForm(context, eventsModel),
            ),
            SizedBox(height: 16),
            Consumer<MyEventsViewModel>(
              builder: (context, eventsModel, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: eventsModel.showOnlyUpcoming,
                      onChanged: (value) {
                        eventsModel.showOnlyUpcoming = value!;
                      },
                    ),
                    Text('Show only upcoming events'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNewEventForm(BuildContext context, MyEventsViewModel eventsModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEventForm(
          onSave: (event) {
            eventsModel.addEvent(event);
          },
        );
      },
    );
  }

  void _showEditDateForm(
      BuildContext context, MyEventsViewModel viewModel, Event event) {
    viewModel.editEventDate(context, event);
  }
}
