import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/events/event_details.dart';
import 'package:hw2/events/event_tap.dart';

import 'package:provider/provider.dart';
import 'package:hw2/events/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';

main() {
  testWidgets('Test viewing an event\'s detail " ',
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

    final eventMore = find.byKey(const Key('more'));

    await tester.tap(eventMore);

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('infodialog')), findsOneWidget);
    
    await tester.tap(find.text('View'));

    await tester.pumpAndSettle();

    expect(find.byType(EventDetailsScreen), findsOneWidget);
  });
}
