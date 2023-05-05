import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/events/event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final int index;

  EventDetailsScreen({required this.index});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final eventsModel = Provider.of<MyEventsViewModel>(context, listen: false);
    final event = eventsModel.getEvent(widget.index);
    final int length = eventsModel.eventsListSize;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 35),
                    onPressed: () => GoRouter.of(context).pop(),
                  ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Start Date: ${DateFormat.yMd().format(event.startDate)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'End Date: ${DateFormat.yMd().format(event.endDate)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.index > 0 ?
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () => context.push('/event/${widget.index - 1}'),
                    ) : const IconButton(onPressed: null, icon: Icon(Icons.arrow_back_ios)),
                    ElevatedButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Home'),
                  ),
                  widget.index < length - 1 ? 
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => context.push('/event/${widget.index + 1}'),
                    ) : const IconButton(onPressed: null, icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
