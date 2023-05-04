import 'package:firebase_database/firebase_database.dart';
import 'package:event_management_app/event.dart';

class DatabaseService {
  final DatabaseReference _eventsRef =
      FirebaseDatabase.instance.reference().child('events');

  // Get a stream of a list of events
  Stream<List<Event>> get eventsStream {
    return _eventsRef.onValue.map((event) {
      List<Event> events = [];
      if (event.snapshot.value != null) {
        (event.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
          if (key != null) {
            Map<String, dynamic> typedValue =
                (value as Map).cast<String, dynamic>();
            events.add(Event.fromMap(typedValue, key));
          }
        });
      }
      return events;
    });
  }
}
