// import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:turf_booking/model/user_model.dart';

class APIs {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage ImageStore = FirebaseStorage.instance;

  static User get user => auth.currentUser!;
  // For creating a new User
  static Future<void> createUser() async {
    final User = TurfUser(
      email: user.email.toString(),
      name: user.displayName.toString(),
      id: user.uid,
    );
    return await firestore.collection('users').doc(user.uid).set(User.toJson());
  }

  //for checking user exits or not..?
  static Future<bool> userExist() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getSelfInfo() {
    final turfUser = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots();
    return turfUser;
  }

  static Future<int> getExistingMemberCount(int selectedSlot) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Members')
        .where('selectedSlot', isEqualTo: selectedSlot)
        .get();

    return querySnapshot.docs.length;
  }

  static saveMembersToFirestore(List<String> members, int selectedSlot) {
    final CollectionReference membersCollection =
        FirebaseFirestore.instance.collection('Members');

    for (int i = 0; i < members.length; i++) {
      membersCollection.add({
        'name': members[i],
        'selectedSlot': selectedSlot,
      });
    }
  }
}
