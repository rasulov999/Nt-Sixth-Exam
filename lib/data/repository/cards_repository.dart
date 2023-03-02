import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nt_sixth_exam/data/model/card_model.dart';
import 'package:nt_sixth_exam/utils/my_utils.dart';

class CardRepository {
  final FirebaseFirestore _firestore;

  CardRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<bool> addCard({required CardModel cardModel}) async {
    try {
      DocumentReference newReview =
          await _firestore.collection("cards").add(cardModel.toJson());
      await _firestore.collection("cards").doc(newReview.id).update({
        "cardId": newReview.id,
      });
      MyUtils.getMyToast(message: "New card successfully added!");
      return newReview.id.isNotEmpty;
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
      return false;
    }
  }

  Future<void> updateCard({required CardModel cardModel}) async {
    try {
      await _firestore
          .collection("cards")
          .doc(cardModel.userId)
          .update(cardModel.toJson());

      MyUtils.getMyToast(message: "Card successfully updated!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> deleteCard({required String doId}) async {
    try {
      await _firestore.collection("cards").doc(doId).delete();
      MyUtils.getMyToast(message: "Card successfully deleted!");
    } on FirebaseException catch (er) {
      MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Stream<List<CardModel>> getCards() =>
      _firestore.collection("cards").snapshots().map(
            (event1) => event1.docs
                .map((doc) => CardModel.fromJson(doc.data()))
                .toList(),
          );
}
