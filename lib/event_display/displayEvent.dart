import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/event_cards/event_tap.dart';
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
            Expanded(
              child: Consumer<MyEventsViewModel>(
                builder: (context, eventsModel, child) {
                  
                  final now = DateTime.now();
                  final upcomingEvents = eventsModel.events
                      .where((event) => event.endDate.isAfter(now)).toList();

                  if (eventsModel.eventsListSize == 0) {
                    // If the list is empty, display a message or a placeholder widget
                    return Center(
                      child: Text(
                        'No upcoming events found',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: eventsModel.showOnlyUpcoming
                          ? upcomingEvents.length
                          : eventsModel.eventsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final event = eventsModel.showOnlyUpcoming
                            ? upcomingEvents[index]
                            : eventsModel.eventsList[index];
                        return EventItem(event: event);
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              key: const Key('add_event_button'),
              child: const Text('Add Event'),
              onPressed: () => _showNewEventForm(context, eventsModel),
            ),
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
                    const Text('Show only upcoming events'),
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
