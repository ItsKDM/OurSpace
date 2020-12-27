import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/widgets.dart';
import 'package:our_space/constants/string.dart';
import 'package:our_space/models/message.dart';
import 'package:our_space/models/user.dart';
import 'package:our_space/provider/image_upload_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:our_space/resources/chat_methods.dart';

class StorageMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Reference _storageReference;

  //user class
  UserA user = UserA();

  Future<String> uploadImageToStorage(File imageFile) async {
    // mention try catch later on

    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      UploadTask storageUploadTask = _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask
          .then((res) => res.ref.getDownloadURL()));
      // print(url);
      return url;
    } catch (e) {
      return null;
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await firestore
        .collection(MESSAGES_COLLECTION)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    await firestore
        .collection(MESSAGES_COLLECTION)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  void uploadImage(
      {File image,
      String receiverId,
      String senderId,
      ImageUploadProvider imageUploadProvider}) async {
    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    setImageMsg(url, receiverId, senderId);
  }
}
