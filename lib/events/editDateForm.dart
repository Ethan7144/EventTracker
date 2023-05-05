import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event.dart';

class EditDateForm extends StatefulWidget {
  final Event event;
  final Function(Event) onSave;

  EditDateForm(
      {required this.event,
      required this.onSave}); // need an event to actually edit

  @override
  _EditDateFormState createState() => _EditDateFormState();
}

class _EditDateFormState extends State<EditDateForm> {
  late DateTime _startDate;
  late DateTime _endDate;
  late DateTime _minEndDate = _startDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.event.startDate;
    _endDate = widget.event.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Event Dates'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.event.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Start Date',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final DateTime? newStartDate = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime(2023),
                lastDate: DateTime(2100),
              );
              if (newStartDate != null) {
                setState(() {
                  _startDate = DateTime(
                    newStartDate.year,
                    newStartDate.month,
                    newStartDate.day,
                  );
                    if (_endDate.isBefore(_startDate)) {
                       _endDate = _startDate;
                    }
                  _minEndDate = _startDate;
                });

              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().add_jm().format(_startDate),
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.edit, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'End Date',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final DateTime? newEndDate = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: _minEndDate,
                lastDate: DateTime(2100),
                
              );
              if (newEndDate != null) {
                setState(() {
                  _endDate = DateTime(
                    newEndDate.year,
                    newEndDate.month,
                    newEndDate.day,
                  );
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().add_jm().format(_endDate),
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.edit, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final modifiedEvent = Event(
              title: widget.event.title,
              description: widget.event.description,
              startDate: _startDate,
              endDate: _endDate,
            );
            widget.onSave(modifiedEvent);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
