import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/models/event.dart';
import 'package:intl/intl.dart';

class SharedEventCard extends StatelessWidget {
  final Event event;
  final int index;

  const SharedEventCard({required this.event, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showEventDetails(context, index),
      key: const Key('shared_event_card'),
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
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(event.title, style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(event.description),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Start: ${DateFormat('MM-dd-yyyy').format(event.startDate)}'),
                  Text('End: ${DateFormat('MM-dd-yyyy').format(event.endDate)}'),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, int index) {
    GoRouter.of(context).push('/event/$index');
  }
}
