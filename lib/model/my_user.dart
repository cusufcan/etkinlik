import 'package:etkinlik/model/my_notification.dart';

class MyUser {
  final String id;
  final String email;
  final String name;
  final String photoURL;
  final String about;
  final List<String> createdEvents;
  final List<String> joinedEvents;
  final List<MyNotification> notifications;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.photoURL,
    required this.about,
    required this.createdEvents,
    required this.joinedEvents,
    this.notifications = const [],
  });

  MyUser.empty({
    this.id = 'null',
    this.email = 'null',
    this.name = 'null',
    this.photoURL = 'null',
    this.about = 'null',
    this.createdEvents = const [],
    this.joinedEvents = const [],
    this.notifications = const [],
  });

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? photoURL,
    String? about,
    List<String>? createdEvents,
    List<String>? joinedEvents,
    List<MyNotification>? notifications,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      about: about ?? this.about,
      createdEvents: createdEvents ?? this.createdEvents,
      joinedEvents: joinedEvents ?? this.joinedEvents,
      notifications: notifications ?? this.notifications,
    );
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'],
      email: map['email'],
      name: map['username'],
      photoURL: map['image_url'],
      about: map['about'],
      createdEvents: List<String>.from(map['created_events']),
      joinedEvents: List<String>.from(map['joined_events']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': name,
      'image_url': photoURL,
      'about': about,
      'created_events': createdEvents,
      'joined_events': joinedEvents,
    };
  }

  @override
  String toString() {
    return 'MyUser{id: $id, email: $email, name: $name, photoURL: $photoURL, about: $about, createdEvents: $createdEvents, joinedEvents: $joinedEvents, notifications: $notifications}';
  }
}
