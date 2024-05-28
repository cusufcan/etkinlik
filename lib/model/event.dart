class Event {
  String id;
  final String imageUrl;
  final String title;
  final int capacity;
  final String description;
  final String date;
  final String time;
  final String location;
  final String creatorId;
  final List<String> joinedUsers;
  final List<String> requestUsers;
  final bool isEmpty;

  Event({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.capacity,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.creatorId,
    required this.joinedUsers,
    required this.requestUsers,
  }) : isEmpty = false;

  Event.empty()
      : id = '',
        imageUrl = '',
        title = '',
        capacity = 0,
        description = '',
        date = '',
        time = '',
        location = '',
        creatorId = '',
        joinedUsers = [],
        requestUsers = [],
        isEmpty = true;

  Event.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        imageUrl = map['imageUrl'],
        title = map['title'],
        capacity = map['capasity'],
        description = map['description'],
        date = map['date'],
        time = map['time'],
        location = map['location'],
        creatorId = map['creatorId'],
        joinedUsers = List<String>.from(map['joined_users']),
        requestUsers = List<String>.from(map['request_users']),
        isEmpty = map['id'] == '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'capasity': capacity,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'creatorId': creatorId,
      'joined_users': joinedUsers,
      'request_users': requestUsers,
    };
  }

  Event copyWith({
    String? id,
    String? imageUrl,
    String? title,
    int? capacity,
    String? description,
    String? date,
    String? time,
    String? location,
    String? creatorId,
    List<String>? joinedUsers,
    List<String>? requestUsers,
  }) {
    return Event(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      capacity: capacity ?? this.capacity,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      creatorId: creatorId ?? this.creatorId,
      joinedUsers: joinedUsers ?? this.joinedUsers,
      requestUsers: requestUsers ?? this.requestUsers,
    );
  }

  @override
  String toString() {
    return 'Event{id: $id, imageUrl: $imageUrl, title: $title, capacity: $capacity, description: $description, date: $date, time: $time, location: $location, creatorId: $creatorId, joinedUsers: $joinedUsers, requestUsers: $requestUsers}';
  }
}
