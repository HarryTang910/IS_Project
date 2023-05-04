import 'package:event_management_app/auth_page.dart';
import 'package:event_management_app/auth_service.dart';
import 'package:event_management_app/create_event_page.dart';
import 'package:event_management_app/database_service.dart';
import 'package:event_management_app/event_details_page.dart';
import 'package:event_management_app/event.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          IconButton(
              onPressed: () async {
                await _authService.signOut();
                // Navigate to the LoginPage
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<Event>>(
        stream: _databaseService.eventsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.eventName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  subtitle: Text(event.description,
                      style: TextStyle(fontSize: 15, color: Colors.blue)),
                  onTap: () {
                    // Navigate to event details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPage(event: event),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create event page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
