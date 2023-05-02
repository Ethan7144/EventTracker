import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'event.dart';

class NewEventForm extends StatefulWidget {
  final Function(Event) onSave;

  NewEventForm({required this.onSave});
  @override
  _NewEventFormState createState() => _NewEventFormState();
}

class _NewEventFormState extends State<NewEventForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _startDate = DateTime.now();
  late DateTime _endDate = DateTime.now();

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    final newEvent = Event(
      title: _title,
      description: _description,
      startDate: _startDate,
      endDate: _endDate,
    );

    widget.onSave(newEvent); // Call the onSave function with the new event
    
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Event'),
      content: SizedBox(
        height: 300,
        width: 200,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onChanged: (value) => _title = value,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 8),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                onChanged: (value) => _startDate = DateTime.parse(value),
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  hintText: 'Select start date and time',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                firstDate: _startDate,
                lastDate: DateTime(2100),
                onChanged: (value) => _endDate = DateTime.parse(value),
                decoration: InputDecoration(
                  labelText: 'End Date',
                  hintText: 'Select end date and time',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: _submitForm,
        ),
      ],
    );
  }
}
