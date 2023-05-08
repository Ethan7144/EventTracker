import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:hw2/routes/goRoutes.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockEventViewModel extends Mock implements MyEventsViewModel {}

void main() {
  testWidgets('Add event form adds an event to the view model',
      (WidgetTester tester) async {
    final eventViewModel = MyEventsViewModel();
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
    // Fill in the form fields with valid data.

    final addEventButton = find.byKey(const Key("add_event_button"));
    final titleField = find.byKey(const Key('title_field'));
    final descriptionField = find.byKey(const Key('description_field'));
    final startDateField = find.byKey(const Key('start_date_field'));
    final endDateField = find.byKey(const Key('end_date_field'));
    await tester.tap(addEventButton);
    await tester.pumpAndSettle();
    await tester.enterText(titleField, 'My Event');
    await tester.enterText(descriptionField, 'This is my event');
    await tester.tap(startDateField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(endDateField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Submit the form.
    final submitButton = find.byKey(const Key('submit_button'));
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify that the event was added to the view model.
    expect(eventViewModel.eventsListSize, 1);
  });
}
