import 'package:hw2/events/displayEvent.dart';
import 'package:hw2/events/addevent.dart';
import 'package:go_router/go_router.dart';

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
      
  ],
);
