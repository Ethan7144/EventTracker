import 'package:hw2/event_display/displayEvent.dart';
import 'package:hw2/event_forms/addevent.dart';
import 'package:go_router/go_router.dart';
import 'package:hw2/event_details/event_details.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, _) =>  MyEventsPage(),
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
