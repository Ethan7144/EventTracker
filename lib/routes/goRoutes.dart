import 'package:hw2/events/displayEvent.dart';
import 'package:hw2/events/addevent.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/events/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/events/event_details.dart';

final Event defaultEvent = Event(title: '', description: '', startDate: DateTime.now(), endDate: DateTime.now());

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, _) => const MyEventsPage(),
    ),
    GoRoute(
      path: '/add',
      name: 'add',
      builder: (context, state) => NewEventForm(onSave: (event) {}),
    ),
    GoRoute(
      path: '/event/:id',
      name: 'event details',
      builder: (context, state) => EventDetailsScreen(index: int.parse(state.pathParameters['id']!)),
    ),
  ],
);
