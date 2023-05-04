import 'package:event_management_app/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'event.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;
  AuthService authService = AuthService();

  EventDetailsPage({required this.event});

  Future<void> _joinEvent(String eventId, String id) async {
    // Implement the logic to join the event
    DatabaseReference _database = FirebaseDatabase.instance.reference();

    try {
      await _database
          .child('event_participants')
          .child(eventId)
          .child(id)
          .set(true);
      print('User joined event successfully');
    } catch (e) {
      print('Error joining event: $e');
    }
  }

  Future<void> _deleteEvent(String id) async {
    // Implement your logic to delete the event using its eventId
    DatabaseReference _database = FirebaseDatabase.instance.reference();

    try {
      await _database.child('events').child(id).remove();
      print('Event deleted successfully');
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.eventName,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Host
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Host: ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: event.host,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        decoration: TextDecoration.none),
                  ),
                ],
                style: DefaultTextStyle.of(context).style,
              ),
            ),
            SizedBox(height: 8),
            // Location
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Location: ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: event.location,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        decoration: TextDecoration.none),
                  ),
                ],
                style: DefaultTextStyle.of(context).style,
              ),
            ),
            SizedBox(height: 8),
            // Max Capacity
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Max Capacity: ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: '${event.maxCapacity}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        decoration: TextDecoration.none),
                  ),
                ],
                style: DefaultTextStyle.of(context).style,
              ),
            ),
            SizedBox(height: 8),
            // Cost
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Cost: ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: '\$${event.cost}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        decoration: TextDecoration.none),
                  ),
                ],
                style: DefaultTextStyle.of(context).style,
              ),
            ),
            SizedBox(height: 8),
            // External Link
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'External Link: ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                    text: event.externalLink,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        decoration: TextDecoration.none),
                  ),
                ],
                style: DefaultTextStyle.of(context).style,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Description:',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              event.description,
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String? userId = authService.getCurrentUserId();
                    if (userId != null) {
                      print('User ID: $userId');
                    } else {
                      print('No user is signed in');
                    }

                    // Call the joinEvent function and pass the eventId
                    await _joinEvent(userId!, event.id);

                    // Navigate back after deletion
                    Navigator.pop(context);
                  },
                  child: Text('Join Event'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () async {
                    // Call the deleteEvent function and pass the eventId
                    await _deleteEvent(event.id);

                    // Navigate back after deletion
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
