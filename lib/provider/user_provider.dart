import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik/base/constant/app_string.dart';
import 'package:etkinlik/model/event.dart';
import 'package:etkinlik/model/my_notification.dart';
import 'package:etkinlik/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final _storage = FirebaseStorage.instance;

class UserNotifier extends StateNotifier<MyUser> {
  UserNotifier() : super(MyUser.empty());

  late final AppString _appString = AppString();

  //* AUTH OPERATIONS

  Future<void> fetchUser() async {
    final collection = _firestore.collection('users');
    final doc = collection.doc(_auth.currentUser!.uid);
    final userData = await doc.get();
    state = MyUser.fromMap(userData.data()!);

    for (var eventId in state.createdEvents) {
      final data = await _firestore.collection("events").doc(eventId).get();
      final Event event = Event.fromMap(data.data()!);
      for (var requestsId in event.requestUsers) {
        final uData =
            await _firestore.collection("users").doc(requestsId).get();
        final MyUser user = MyUser.fromMap(uData.data()!);
        state = state.copyWith(
          notifications: [
            ...state.notifications,
            MyNotification(
              title: '${event.title} etkinliğine yeni istek!',
              body: '${user.name} etkinliğe katılmak istiyor.',
              eventId: event.id,
              requestUserId: user.id,
            ),
          ],
        );
      }
    }
  }

  Future<UserCredential> signInUser(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createUser(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
    state = MyUser.empty();
  }

  //* DATABASE OPERATIONS

  Future<String> uploadImage(File? image) async {
    if (image == null) return _appString.defaultPPUrl;

    final storageRef = _storage
        .ref()
        .child('user_images')
        .child('${_auth.currentUser!.uid}.jpg');

    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }

  Future<void> setUserToDB(MyUser user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(user.toMap());

    state = user;
  }

  //* PROFILE OPERATIONS

  Future<void> changeProfileImage(File image) async {
    final imageUrl = await uploadImage(image);
    state = state.copyWith(photoURL: imageUrl);
    await setUserToDB(state);
  }

  Future<void> deleteProfileImage() async {
    final storageRef = _storage
        .ref()
        .child('user_images')
        .child('${_auth.currentUser!.uid}.jpg');

    await storageRef.delete();
    state = state.copyWith(photoURL: _appString.defaultPPUrl);
    await setUserToDB(state);
  }

  Future<void> changeProfileInfo(String? name, String? about) async {
    state = state.copyWith(name: name, about: about);
    await setUserToDB(state);
  }

  Future<void> deleteAccount(AuthCredential credential) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).delete();
    if (state.photoURL != _appString.defaultPPUrl) {
      await _storage
          .ref()
          .child('user_images')
          .child('${_auth.currentUser!.uid}.jpg')
          .delete();
    }
    await _auth.currentUser!.reauthenticateWithCredential(credential);
    await _auth.currentUser!.delete();

    state = MyUser.empty();
  }

  //* EVENT OPERATIONS

  Future<void> createEvent(String eventId) async {
    state = state.copyWith(createdEvents: [eventId, ...state.createdEvents]);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'created_events': state.createdEvents,
    });
  }

  Future<void> leaveEvent(String eventId) async {
    state = state.copyWith(
      joinedEvents: state.joinedEvents.where((id) => id != eventId).toList(),
    );

    await _firestore.collection('events').doc(eventId).update({
      'joined_users': FieldValue.arrayRemove([_auth.currentUser!.uid]),
    });

    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'joined_events': state.joinedEvents,
    });
  }

  //* DB OPERATIONS

  Future<List<MyUser>> getUsersByIds(List<String> ids) async {
    final rawUsers = await _firestore.collection('users').get();

    final List<MyUser> convertedUsers = [];
    for (var user in rawUsers.docs) {
      if (ids.contains(user.id)) {
        convertedUsers.add(MyUser.fromMap(user.data()));
      }
    }
    return convertedUsers;
  }

  //* NOTIFICATION OPERATIONS

  void deleteNotification(MyNotification notification) {
    state = state.copyWith(
      notifications:
          state.notifications.where((n) => n != notification).toList(),
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, MyUser>((ref) {
  return UserNotifier();
});
