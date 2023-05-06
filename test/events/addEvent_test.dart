import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/events/addevent.dart';
import 'package:hw2/main.dart';
import 'package:hw2/events/event.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:hw2/events/addevent.dart';

class MockEventViewModel extends Mock implements MyEventsViewModel {}

void main() {
  testWidgets('Add event form adds an event to the view model',
      (WidgetTester tester) async {
    // Create a mock view model to use in the test.
    final viewModel = MockEventViewModel();

    // Build the app and inject the mock view model.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: viewModel),
        ],
        child:  MaterialApp(
          home: Scaffold(
            body: NewEventForm(onSave: (event) {}),
          ),
        ),
      ),
    );

    // Fill in the form fields with valid data.
    final titleField = find.byKey(const ValueKey('title_field'));
    final descriptionField = find.byKey(const ValueKey('description_field'));
    final startDateField = find.byKey(const ValueKey('start_date_field'));
    final endDateField = find.byKey(const ValueKey('end_date_field'));
    await tester.enterText(titleField, 'My Event');
    await tester.enterText(descriptionField, 'This is my event');
    await tester.tap(startDateField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.tap(endDateField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Submit the form.
    final submitButton = find.byKey(const ValueKey('submit_button'));
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify that the event was added to the view model.
    final expectedEvent = Event(
      title: 'My Event',
      description: 'This is my event',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
    verify(viewModel.addEvent(expectedEvent)).called(1);
  });
}
