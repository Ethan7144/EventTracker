import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:provider/provider.dart';
import 'event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    final eventsModel = Provider.of<MyEventsViewModel>(context, listen: false);
    final index = eventsModel.events.indexOf(event);
    return InkWell(
      key: const Key('event_card'),
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
            '${DateFormat.yMMMd().format(event.startDate)} - ${DateFormat.yMMMd().format(event.endDate)}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  key: const Key('deletebutton'),
                  onPressed: () {
                    eventsModel.deleteEvent(event);
                  },
                  child: const Text('Delete'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  key: const Key('more'),
                  onPressed: () {
                    _showInfoDialog(context, eventsModel, event);
                  },
                  child: const Text('More'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _showEditDateForm(
      BuildContext context, MyEventsViewModel viewModel, Event event) {
    viewModel.editEventDate(context, event);
  }

  void _showEventDetailsDialog(
      BuildContext context, MyEventsViewModel eventsModel, Event event) {
    eventsModel.showEventDetails(context, event);
  }

  void _showInfoDialog(
      BuildContext context, MyEventsViewModel eventsModel, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('infodialog'),
          title: Text(event.title),
          content: Text(event.description),
          actions: <Widget>[
            TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showEditDateForm(context, eventsModel, event);
                }),
            TextButton(
              key: const Key('viewbutton'),
              child: const Text('View'),
              onPressed: () {
                Navigator.of(context).pop();
                _showEventDetails(context, eventsModel);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEventDetails(BuildContext context, MyEventsViewModel eventsModel) {
    final eventsModel = Provider.of<MyEventsViewModel>(context, listen: false);
    final index = eventsModel.events.indexOf(event);
    GoRouter.of(context).push('/event/$index');
  }
}
