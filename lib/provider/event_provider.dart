import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik/base/helper/date_helper.dart';
import 'package:etkinlik/model/event.dart';
import 'package:etkinlik/model/my_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;

class EventNotifier extends StateNotifier<List<Event>> {
  EventNotifier() : super(const []);

  Future<void> fetchEvents() async {
    final events = await _firestore.collection('events').get();

    state = events.docs.map((e) {
      return Event.fromMap(
        e.data(),
      );
    }).toList();

    sortEvents();
  }

  Future<void> addEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).set(event.toMap());

    state = [...state, event];

    sortEvents();
  }

  Future<void> removeEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).delete();
    await _firestore.collection('users').doc(event.creatorId).update({
      'created_events': FieldValue.arrayRemove([event.id])
    });
    for (var user in event.joinedUsers) {
      await _firestore.collection('users').doc(user).update({
        'joined_events': FieldValue.arrayRemove([event.id])
      });
    }
    if (!event.imageUrl.contains('no_image.jpg')) {
      await _storage
          .ref()
          .child('event_images')
          .child('${event.id}.jpg')
          .delete();
    }
    state = state.where((e) => e.id != event.id).toList();

    sortEvents();
  }

  Future<void> updateEvent(Event event) async {
    state = state.map((e) {
      if (e.id == event.id) {
        return event;
      }
      return e;
    }).toList();
  }

  Future<void> requestToJoinEvent(Event event) async {
    await _firestore.collection("events").doc(event.id).update({
      "request_users":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });

    state = state.map((e) {
      if (e.id == event.id) {
        return e.copyWith(
          requestUsers: [
            ...e.requestUsers,
            FirebaseAuth.instance.currentUser!.uid
          ],
        );
      }
      return e;
    }).toList();
  }

  Future<void> cancelEventRequest(Event event) async {
    await _firestore.collection("events").doc(event.id).update({
      "request_users":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });

    state = state.map((e) {
      if (e.id == event.id) {
        return e.copyWith(
          requestUsers: e.requestUsers
              .where((id) => id != FirebaseAuth.instance.currentUser!.uid)
              .toList(),
        );
      }
      return e;
    }).toList();
  }

  Future<void> acceptEventRequest(MyNotification notification) async {
    await _firestore.collection("events").doc(notification.eventId).update({
      "request_users": FieldValue.arrayRemove([notification.requestUserId]),
      "joined_users": FieldValue.arrayUnion([notification.requestUserId]),
    });

    await _firestore
        .collection("users")
        .doc(notification.requestUserId)
        .update({
      "joined_events": FieldValue.arrayUnion([notification.eventId]),
    });

    state = state.map((e) {
      if (e.id == notification.eventId) {
        return e.copyWith(
          requestUsers: e.requestUsers
              .where((id) => id != notification.requestUserId)
              .toList(),
          joinedUsers: [...e.joinedUsers, notification.requestUserId],
        );
      }
      return e;
    }).toList();
  }

  Future<void> rejectEventRequest(MyNotification notification) async {
    await _firestore.collection("events").doc(notification.eventId).update({
      "request_users": FieldValue.arrayRemove([notification.requestUserId]),
    });

    state = state.map((e) {
      if (e.id == notification.eventId) {
        return e.copyWith(
          requestUsers: e.requestUsers
              .where((id) => id != notification.requestUserId)
              .toList(),
        );
      }
      return e;
    }).toList();
  }

  Future<void> leaveEvent(Event event) async {
    state = state.map((e) {
      if (e.id == event.id) {
        return e.copyWith(
          joinedUsers: e.joinedUsers
              .where((id) => id != FirebaseAuth.instance.currentUser!.uid)
              .toList(),
        );
      }
      return e;
    }).toList();
  }

  void sortEvents() {
    state.sort(
      (a, b) {
        DateTime aDate = convertToDateTime(a.date, a.time);
        DateTime bDate = convertToDateTime(b.date, b.time);
        return bDate.compareTo(aDate);
      },
    );
  }

  Future<String> uploadImage(String eventId, File image) async {
    final ref = _storage.ref().child('event_images').child('$eventId.jpg');
    await ref.putFile(image);
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  void resetEvents() {
    state = [];
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, List<Event>>((ref) {
  return EventNotifier();
});
