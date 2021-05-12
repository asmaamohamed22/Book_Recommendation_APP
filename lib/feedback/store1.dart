import 'package:book_recommend/constant.dart';
import 'package:book_recommend/feedback/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addFeedback(Contact contact) async {
    await _firestore.collection(kMessagesCollection).add({
      kFeedbackName: contact.fName,
      kFeedbackEmail: contact.fEmail,
      kFeedbackMessage: contact.fMessage,
      kTime: Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> loadFeedback() {
    return _firestore
        .collection(kMessagesCollection)
        .orderBy(kTime, descending: true)
        .snapshots();
  }

  deleteMessage(documentId) async {
    await _firestore.collection(kMessagesCollection).doc(documentId).delete();
  }
}
