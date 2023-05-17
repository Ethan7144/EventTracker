import 'package:floor/floor.dart';
import 'package:hw2/dateTimeConverter/dateTimeConverter.dart'; // Import the DateTimeConverter

@Entity(tableName: 'Event')
@TypeConverters([DateTimeConverter])
class Event {
  @primaryKey
  String title;
  String description;

  DateTime startDate;
  DateTime endDate;

  Event({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });
}
