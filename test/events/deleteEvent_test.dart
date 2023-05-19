import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/dao/event_dao.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';
import 'displayEvent_test.mocks.dart';

main() {
  testWidgets('Testing the delete button actually deletes the event',
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
    when(mockEventViewModel.events).thenReturn([]);
    when(mockEventViewModel.eventsList).thenReturn(events);
    await tester.pumpWidget(ChangeNotifierProvider<MyEventsViewModel>.value(
        value: mockEventViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        )));

    final eventMore = find.byIcon((Icons.delete_forever));

    await tester.tap(eventMore); // delete test

    await tester.pumpAndSettle();
    events = [];
    when(mockEventViewModel.eventsListSize).thenReturn(events.length);
    when(mockEventViewModel.events).thenReturn(events);
    when(mockEventViewModel.showOnlyUpcoming)
        .thenAnswer((realInvocation) => false);
    when(mockEventViewModel.events).thenReturn([]);
    when(mockEventViewModel.eventsList).thenReturn(events);
    expect(mockEventViewModel.eventsListSize, 0);
  });
}
