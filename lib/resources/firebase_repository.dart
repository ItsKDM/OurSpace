// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:our_space/models/message.dart';
// import 'package:our_space/provider/image_upload_provider.dart';
// import 'package:our_space/resources/firebase_methods.dart';
// import 'package:our_space/models/user.dart';

// class FirebaseRepository {
//   FirebaseMethods _firebaseMethods = FirebaseMethods();

//   Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

//   Future<User> signIn() => _firebaseMethods.signIn();

//   Future<UserA> getUserDetails() => _firebaseMethods.getUserDetails();

//   Future<bool> authenticateUser(User user) =>
//       _firebaseMethods.authenticateUser(user);

//   Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

//   //responsible for signing out
//   Future<void> signOut() => _firebaseMethods.signOut();

//   Future<List<UserA>> fetchAllUsers(User user) =>
//       _firebaseMethods.fetchAllUsers(user);

//   Future<void> addMessageToDb(Message message, UserA sender, UserA receiver) =>
//       _firebaseMethods.addMessageToDb(message, sender, receiver);

//   void uploadImage(
//           {@required File image,
//           @required String receiverId,
//           @required String senderId,
//           @required ImageUploadProvider imageUploadProvider}) =>
//       _firebaseMethods.uploadImage(
//           image, receiverId, senderId, imageUploadProvider);
// }
