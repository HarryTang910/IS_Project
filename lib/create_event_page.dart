import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  String _eventName = '';
  String _host = '';
  String _location = '';
  int _maxCapacity = 0;
  double _cost = 0.0;
  String _externalLink = '';
  String _description = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the event to the database

      DatabaseReference _eventRef =
          FirebaseDatabase.instance.reference().child('events');

      String? key = _eventRef.push().key;

      await _eventRef.child(key!).set({
        'event_name': _eventName,
        'host': _host,
        'location': _location,
        'max_capacity': _maxCapacity,
        'cost': _cost,
        'external_link': _externalLink,
        'description': _description,
      });

      print('Event Name: $_eventName, Host: $_host, Location: $_location, '
          'Max Capacity: $_maxCapacity, Cost: $_cost, '
          'External Link: $_externalLink, Description: $_description');

      // Navigate back to the main page after submitting the form
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Event Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an event name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _eventName = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Host'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a host';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _host = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _location = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Max Capacity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a max capacity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _maxCapacity = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cost'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a cost';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cost = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'External Link'),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an external link';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _externalLink = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Create Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
