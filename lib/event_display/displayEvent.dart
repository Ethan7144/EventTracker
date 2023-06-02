import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/event_cards/event_tap.dart';
import 'package:hw2/firebase/firebase_functions.dart';
import 'package:hw2/models/event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:hw2/models/event_view_model.dart';

class MyEventsPage extends StatelessWidget {
  MyEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyEventsViewModel viewModel = Provider.of<MyEventsViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildEventList(viewModel.events, 'Local Events'),
                  _buildFirebaseEventList(viewModel.showOnlyUpcoming),
                ],
              ),
            ),
            ElevatedButton(
              key: const Key('add_event_button'),
              child: const Text('Add Event'),
              onPressed: () => _showNewEventForm(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  key: const Key('upcoming_box'),
                  value: viewModel.showOnlyUpcoming,
                  onChanged: (value) {
                    viewModel.showOnlyUpcoming = value ?? false;
                  },
                ),
                const Text('Show only upcoming events'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirebaseEventList(bool showOnlyUpcoming) {
    return FutureBuilder<List<Event>>(
      future: FirebaseFunctions.loadEvents(),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while data is being fetched
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          // Show an error message if there's an error
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final events = snapshot.data ?? [];

        if (events.isEmpty) {
          // Show a message when there is no data
          return const Center(child: Text('No events found'));
        }

        final filteredEvents = showOnlyUpcoming
            ? events.where((event) => event.startDate.isAfter(DateTime.now())).toList()
            : events;

        return _buildEventList(filteredEvents, 'Shared Events');
      },
    );
  }

  Widget _buildEventList(List<Event>? events, String title) {
    if (events == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (events.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              'No events found',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            final event = events[index];
            return EventItem(event: event);
          },
        ),
      ],
    );
  }

  void _showNewEventForm(BuildContext context) {
    GoRouter.of(context).push('/add');
  }
}
