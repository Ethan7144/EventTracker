import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/event_details/event_details.dart';
import 'package:hw2/event_cards/event_tap.dart';

import 'package:provider/provider.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';

main() {
  testWidgets('Test if Event is editing properly',
          (WidgetTester tester) async {
        Event event1 = Event(
            title: "Event 1",
            description: "Placeholder 1",
            startDate: DateTime.utc(2023, 5, 1),
            endDate: DateTime.utc(2023, 5, 2));

        final eventViewModel = MyEventsViewModel();
        eventViewModel.addEvent(event1);
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<MyEventsViewModel>(
                create: (context) => eventViewModel,
              ),
            ],
            child: MaterialApp.router(
              title: 'My Events App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routerConfig: router,
            ),
          ),
        );

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
