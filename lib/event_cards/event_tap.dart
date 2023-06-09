import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import 'package:hw2/myApp/myApp.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final int index; // Added index parameter
  const EventItem({required this.event, required this.index});

  @override
  Widget build(BuildContext context) {
    final eventsModel = Provider.of<MyEventsViewModel>(context, listen: false);
    return InkWell(
      onTap: () => _showEventDetails(context, index), // Pass the index instead of eventsModel
      key: const Key('event_card'),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade300, Colors.lightBlue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(10, 10),
                blurRadius: 20,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(event.title, style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(event.description),
                trailing: IconButton(
                  key: const Key('delete_button'),
                  icon: const Icon(Icons.delete_forever, color: Colors.white),
                  onPressed: () {
                    eventsModel.deleteEvent(event);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Start: ${DateFormat('MM-dd-yyyy').format(event.startDate)}'),
                  Text('End: ${DateFormat('MM-dd-yyyy').format(event.endDate)}'),
                  ElevatedButton(
                    key: const Key('edit_button'),
                    onPressed: () => _showEditDateForm(context, eventsModel, event),
                    child: const Text('Edit', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDateForm(BuildContext context, MyEventsViewModel viewModel, Event event) {
    viewModel.editEventDate(context, event);
  }

  void _showEventDetails(BuildContext context, int index) {
    GoRouter.of(context).push('/event/$index');
  }
}
