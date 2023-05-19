import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/event_display/displayEvent.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:hw2/models/event.dart';

import 'addEvent_test.mocks.dart';

void main() {
  testWidgets('Test to find if events details are showing properly" ',
      (WidgetTester tester) async {
    final eventViewModel = MockMyEventsViewModel();
    
    final event1 = Event(
        title: 'Event 1',
        description: 'Description of event 1',
        startDate: DateTime(2023, 6, 1),
        endDate: DateTime(2023, 6, 3));
    final event2 = Event(
        title: 'Event 2',
        description: 'Description of event 2',
        startDate: DateTime(2023, 6, 5),
        endDate: DateTime(2023, 6, 7));
    List<Event> events = [event1, event2];
    
    when(eventViewModel.eventsListSize).thenReturn(events.length);
    when(eventViewModel.events).thenReturn(events);
    when(eventViewModel.showOnlyUpcoming)
        .thenAnswer((realInvocation) => false);
    when(eventViewModel.events).thenReturn([]);
    when(eventViewModel.eventsList).thenReturn(events);
    await tester.pumpWidget(ChangeNotifierProvider<MyEventsViewModel>.value(
        value: eventViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        )));
    // Fill in t
    expect(find.text("Event 1"), findsOneWidget);
    expect(find.text("Description of event 1"), findsOneWidget);
    expect(find.text("Start: 06-01-2023"), findsOneWidget);
    expect(find.text("End: 06-03-2023"), findsOneWidget);
    expect(find.text("Event 2"), findsOneWidget);
    expect(find.text("Description of event 2"), findsOneWidget);
    expect(find.text("Start: 06-05-2023"), findsOneWidget);
    expect(find.text("End: 06-07-2023"), findsOneWidget);
    
  });
}
