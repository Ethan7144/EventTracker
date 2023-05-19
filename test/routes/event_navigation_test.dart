import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/event_details/event_details.dart';
import 'package:mockito/mockito.dart';

import 'package:provider/provider.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';

import '../events/addEvent_test.mocks.dart';

main() {
  testWidgets('Test viewing an event\'s details',
      (WidgetTester tester) async {
    Event event1 = Event(
            title: "Event 1",
            description: "Placeholder 1",
            startDate: DateTime.utc(2023, 5, 1),
            endDate: DateTime.utc(2023, 5, 2));
            List<Event> events = [event1];

       final mockEventViewModel = MockMyEventsViewModel();
    when(mockEventViewModel.eventsListSize).thenReturn(events.length);
    when(mockEventViewModel.events).thenReturn(events);
    when(mockEventViewModel.showOnlyUpcoming)
        .thenAnswer((realInvocation) => false);
    when(mockEventViewModel.events).thenReturn(events);
    when(mockEventViewModel.eventsList).thenReturn(events);
    when(mockEventViewModel.getSortedEventsByStartDate()).  // added this line
        thenReturn(events); // added this line
    await tester.pumpWidget(ChangeNotifierProvider<MyEventsViewModel>.value(
        value: mockEventViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        )));

    final eventMore = find.byKey(const Key('event_card'));

    await tester.tap(eventMore);

    await tester.pumpAndSettle();

    expect(find.byType(EventDetailsScreen), findsOneWidget);
  });
}
