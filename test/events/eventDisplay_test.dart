import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/event_display/displayEvent.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:provider/provider.dart';
import 'package:hw2/models/event.dart';

void main() {
  testWidgets('Test to find if events details are showing properly" ',
      (WidgetTester tester) async {
    final eventViewModel = MyEventsViewModel();
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
    eventViewModel.addEvent(event1);
    eventViewModel.addEvent(event2);
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => eventViewModel,
      child: const MaterialApp(
          home: Scaffold(
        body: MyEventsPage(),
      )),
    ));
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
