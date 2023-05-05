import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/events/event_tap.dart';
import 'package:provider/provider.dart';

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
                      return EventItem(event: event);
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
    GoRouter.of(context).push('/add');
  }
}


