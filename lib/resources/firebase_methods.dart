// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:our_space/constants/string.dart';
// import 'package:our_space/models/message.dart';
// import 'package:our_space/models/user.dart';
// import 'package:our_space/provider/image_upload_provider.dart';
// import 'package:our_space/utils/utilities.dart';

// class FirebaseMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   GoogleSignIn _googleSignIn = GoogleSignIn();
//   static final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   static final CollectionReference _userCollection =
//       _firestore.collection(USERS_COLLECTION);

//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Reference _storageReference;

//   //user class
//   UserA user = UserA();

//   Future<User> getCurrentUser() async {
//     User currentUser;
//     currentUser = _auth.currentUser;
//     return currentUser;
//   }

//   Future<UserA> getUserDetails() async {
//     User currentUser = await getCurrentUser();

//     DocumentSnapshot documentSnapshot =
//         await _userCollection.doc(currentUser.uid).get();

//     return UserA.fromMap(documentSnapshot.data());
//   }

//   Future<User> signIn() async {
//     GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
//     GoogleSignInAuthentication _signInAuthentication =
//         await _signInAccount.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: _signInAuthentication.accessToken,
//         idToken: _signInAuthentication.idToken);

//     // UserCredential user = await _auth.signInWithCredential(credential);
//     // user = user.user as UserCredential;
//     // // return user;
//     // return signIn();
//     UserCredential user = await _auth.signInWithCredential(credential);
//     return user.user;
//   }

//   Future<bool> authenticateUser(User user) async {
//     QuerySnapshot result = await firestore
//         .collection(USERS_COLLECTION)
//         .where(EMAIL_FIELD, isEqualTo: user.email)
//         .get();

//     final List<DocumentSnapshot> docs = result.docs;

//     //if user is registered then length of list > 0 or else less than 0
//     return docs.length == 0 ? true : false;
//   }

//   Future<void> addDataToDb(User currentUser) async {
//     String username = Utils.getUsername(currentUser.email);
//     user = UserA(
//         uid: currentUser.uid,
//         email: currentUser.email,
//         name: currentUser.displayName,
//         profilePhoto: currentUser.photoURL,
//         username: username);

//     firestore
//         .collection(USERS_COLLECTION)
//         .doc(currentUser.uid)
//         .set(user.toMap(user));
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.disconnect();
//     await _googleSignIn.signOut();
//     return await _auth.signOut();
//   }

//   // ignore: missing_return
//   Future<List<UserA>> fetchAllUsers(User currentUser) async {
//     // ignore: deprecated_member_use
//     List<UserA> userList = List<UserA>();

//     QuerySnapshot querySnapshot =
//         await firestore.collection(USERS_COLLECTION).get();

//     for (var i = 0; i < querySnapshot.docs.length; i++) {
//       if (querySnapshot.docs[i].id != currentUser.uid) {
//         userList.add(UserA.fromMap(querySnapshot.docs[i].data()));
//       }
//     }
//     return userList;
//   }

//   Future<void> addMessageToDb(
//       Message message, UserA sender, UserA receiver) async {
//     var map = message.toMap();

//     await firestore
//         .collection(MESSAGES_COLLECTION)
//         .doc(message.senderId)
//         .collection(message.receiverId)
//         .add(map);

//     return await firestore
//         .collection(MESSAGES_COLLECTION)
//         .doc(message.receiverId)
//         .collection(message.senderId)
//         .add(map);
//   }

//   Future<String> uploadImageToStorage(File imageFile) async {
//     // mention try catch later on

//     try {
//       _storageReference = FirebaseStorage.instance
//           .ref()
//           .child('${DateTime.now().millisecondsSinceEpoch}');
//       UploadTask storageUploadTask = _storageReference.putFile(imageFile);
//       var url = await (await storageUploadTask
//           .then((res) => res.ref.getDownloadURL()));
//       // print(url);
//       return url;
//     } catch (e) {
//       return null;
//     }
//   }

//   void setImageMsg(String url, String receiverId, String senderId) async {
//     Message message;

//     message = Message.imageMessage(
//         message: "IMAGE",
//         receiverId: receiverId,
//         senderId: senderId,
//         photoUrl: url,
//         timestamp: Timestamp.now(),
//         type: 'image');

//     // create imagemap
//     var map = message.toImageMap();

//     // var map = Map<String, dynamic>();
//     await firestore
//         .collection(MESSAGES_COLLECTION)
//         .doc(message.senderId)
//         .collection(message.receiverId)
//         .add(map);

//     await firestore
//         .collection(MESSAGES_COLLECTION)
//         .doc(message.receiverId)
//         .collection(message.senderId)
//         .add(map);
//   }

//   void uploadImage(File image, String receiverId, String senderId,
//       ImageUploadProvider imageUploadProvider) async {
//     // Set some loading value to db and show it to user
//     imageUploadProvider.setToLoading();

//     // Get url from the image bucket
//     String url = await uploadImageToStorage(image);

//     // Hide loading
//     imageUploadProvider.setToIdle();

//     setImageMsg(url, receiverId, senderId);
//   }
// }
