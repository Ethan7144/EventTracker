// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/event_forms/addevent.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:hw2/routes/goRoutes.dart';

import '../events/displayEvent_test.mocks.dart';

@GenerateMocks([MyEventsViewModel])
void main() {
  testWidgets(
    'Test if button/link to add event form initiates navigation to the correct route',
    (WidgetTester tester) async {

        List<Event> events = [];
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

      // Find the button/link that navigates to the add event form route
      final addEventButton = find.byKey(const Key('add_event_button'));

      // Verify that the button/link is displayed on the screen
      expect(addEventButton, findsOneWidget);

      // Tap the button/link
      await tester.tap(addEventButton);

      // Wait for the navigation to complete
      await tester.pumpAndSettle();

      expect(find.byType(NewEventForm), findsOneWidget);
    },
  );
}
