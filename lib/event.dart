class Event {
  final String id;
  final String eventName;
  final String host;
  final String location;
  final int maxCapacity;
  final double cost;
  final String externalLink;
  final String description;

  Event({
    required this.id,
    required this.eventName,
    required this.host,
    required this.location,
    required this.maxCapacity,
    required this.cost,
    required this.externalLink,
    required this.description,
  });

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    return Event(
      id: documentId,
      eventName: data['event_name']?.toString() ?? "",
      host: data['host']?.toString() ?? "",
      location: data['location']?.toString() ?? "",
      maxCapacity: data['max_capacity'] as int? ?? 0,
      cost: (data['cost'] as num?)?.toDouble() ?? 0,
      externalLink: data['external_link']?.toString() ?? "",
      description: data['description']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'host': host,
      'location': location,
      'maxCapacity': maxCapacity,
      'cost': cost,
      'externalLink': externalLink,
      'description': description,
    };
  }
}
