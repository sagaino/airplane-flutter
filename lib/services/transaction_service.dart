import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final CollectionReference _transactionRef =
      // FirebaseFirestore.instance.collection("transactions");
      FirebaseFirestore.instance.collection("users");

  Future<void> createTransaction(TransactionModel transaction, String id, int balance) async {
    try {
      _transactionRef.doc(id).collection("history").add({
        'destination': transaction.destination.toJson(),
        'amountOfTraveler': transaction.amountOfTraveler,
        'selectedSeat': transaction.selectedSeat,
        'insurance': transaction.insurance,
        'refundable': transaction.refundable,
        'vat': transaction.vat,
        'price': transaction.price,
        'grandTotal': transaction.grandTotal,
      });
      _transactionRef.doc(id).update({"balance" : balance - transaction.grandTotal});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> fetchTransaction(String id) async {
    try {
      QuerySnapshot result = await _transactionRef.doc(id).collection("history").get();
      List<TransactionModel> transactions = result.docs.map(
        (item) {
          return TransactionModel.fromJson(
            item.id,
            item.data() as Map<String, dynamic>,
          );
        },
      ).toList();
      return transactions;
    } catch (e) {
      rethrow;
    }
  }
}
