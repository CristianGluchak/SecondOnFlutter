import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference contacts =
      FirebaseFirestore.instance.collection("contacts");

  get userId => FirebaseAuth.instance.currentUser!.uid;

  Future addContact(String name, String number) async {
    return contacts.add({"name": name, "number": number, "userId": userId});
  }

  Stream<QuerySnapshot> getContacts() {
    return contacts.where("userId", isEqualTo: userId).snapshots();
  }

  Future<void> updateContact(String docId, String newName, String newNumber) {
    return contacts.doc(docId).update({"name": newName, "number": newNumber});
  }

  Future<void> deleteContact(String docId) {
    return contacts.doc(docId).delete();
  }

  Future<DocumentSnapshot> getContact(String docId) {
    return contacts.doc(docId).get();
  }
}
