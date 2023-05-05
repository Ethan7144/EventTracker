import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'event.dart';
import 'package:hw2/models/event_view_model.dart';

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

  void _submitForm(MyEventsViewModel viewModel) {
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
    
    viewModel.addEvent(newEvent);
    print('Event added to VMC.');
    GoRouter.of(context).go('/home');
  }

  @override
  Widget build(BuildContext context) {
    DateTime _minEndDate = DateTime.now();
    return Consumer<MyEventsViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Event'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onChanged: (value) => _description = value,
                  ),
                  const SizedBox(height: 8),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2100),
                    onChanged: (value) {
                      _startDate = DateTime.parse(value);
                      _minEndDate = _startDate;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'Select start date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    firstDate: _minEndDate,
                    lastDate: DateTime(2100),
                    onChanged: (value) => _endDate = DateTime.parse(value),
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      hintText: 'Select end date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () => GoRouter.of(context).go('/home'),
            ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () => _submitForm(model),
                ),
                ],
              ),
            ),
          ),
            
        );
      },
    );
  }
}
