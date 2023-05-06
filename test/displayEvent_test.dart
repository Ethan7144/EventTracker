// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/events/displayEvent.dart';

import 'package:hw2/main.dart';
import 'package:hw2/models/event_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

@GenerateMocks([MyEventsViewModel])
main(){
  testWidgets('Test to find if no events text is displaying properly" ',(WidgetTester tester) async {
    await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => MyEventsViewModel(),
          child: const MaterialApp(
              home: Scaffold(
                body: MyEventsPage(),
              )),
        )
    );
    expect(find.text("No upcoming events found"), findsOneWidget);
  });
}