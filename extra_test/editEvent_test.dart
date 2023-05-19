import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:provider/provider.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';

import '../test/events/addEvent_test.mocks.dart';

main() {
  testWidgets('Test if Event is editing properly',
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
    await tester.pumpWidget(ChangeNotifierProvider<MyEventsViewModel>.value(
        value: mockEventViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        )));
    // Fill in the f

        expect(find.text("Start: 05-01-2023"), findsOneWidget);

        final eventEdit = find.byKey(const Key('edit_button'));
        await tester.tap(eventEdit);
        await tester.pumpAndSettle();
        final startEdit = find.byKey(const Key('StartEdit'));
        await tester.tap(startEdit);
        await tester.pumpAndSettle();
        await tester.tap(find.text('5'));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        expect(find.text("Start: 05-05-2023"), findsOneWidget);

      });
}
