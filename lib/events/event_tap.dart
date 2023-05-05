import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: () {
        _showInfoDialog(context, eventsModel, event);
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
            child: const Text('Delete'),
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
        showDialog(context: context, 
          builder: (BuildContext context) {
              return AlertDialog(
              title: Text(event.title),
              content: Text(event.description),
              actions: <Widget>[
                TextButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showEditDateForm(context, eventsModel, event);
                  },
                ),
                TextButton(
                  child: const Text('View'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showEventDetailsDialog(context, eventsModel, event);
                  },
                ),
              ],
            );
          },
    );
  }
}
