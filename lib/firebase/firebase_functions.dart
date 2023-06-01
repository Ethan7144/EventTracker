import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hw2/models/event.dart';
import 'package:hw2/models/event_view_model.dart';

class FirebaseFunctions {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<Event>> loadEvents() async {
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('events').doc().get();
  if (snapshot.exists) {
    List<Event> eventList = List<Event>.from(
      snapshot.data()!['events'].map(
        (event) => Event(
          title: event['title'],
          description: event['description'],
          startDate: DateTime.parse(event['startDate']),
          endDate: DateTime.parse(event['endDate']),
        ),
      ),
    );
    return eventList;
  }
  return [];
}



  static void saveEvents(MyEventsViewModel viewModel) async {
  await FirebaseFirestore.instance.collection('events').doc().set({
    'events': viewModel.eventsList.map((event) => {
      'title': event.title,
      'description': event.description,
      'startDate': event.startDate.toString(),
      'endDate': event.endDate.toString(),
    }).toList(),
  });
}

  static void deleteEvent(int index, MyEventsViewModel viewModel) {
  Event event = viewModel.getEvent(index);
  viewModel.deleteEvent(event);
}
}
