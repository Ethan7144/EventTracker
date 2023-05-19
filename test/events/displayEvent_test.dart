// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'addEvent_test.mocks.dart';

@GenerateMocks([MyEventsViewModel])
main() {
  testWidgets('Test for no event in app" ', (WidgetTester tester) async {
    final mockEventViewModel = MockMyEventsViewModel();
    when(mockEventViewModel.eventsListSize).thenReturn(0);
     when(mockEventViewModel.showOnlyUpcoming)
        .thenAnswer((realInvocation) => false);
    when(mockEventViewModel.events).thenReturn([]);
    when(mockEventViewModel.eventsList).thenReturn([]);
    await tester.pumpWidget(ChangeNotifierProvider<MyEventsViewModel>.value(
        value: mockEventViewModel,
        child: MaterialApp.router(
          routerConfig: router,
        )));

    await tester.pumpAndSettle();
    expect(find.text("No upcoming events found"), findsOneWidget);
  });
}
