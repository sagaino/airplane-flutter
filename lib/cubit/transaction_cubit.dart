import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/models/user_model.dart';
import 'package:airplane/services/transaction_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void createTransaction(TransactionModel transaction, String id, int balance) async {
    try {
      emit(TransactionLoading());
      await TransactionService().createTransaction(transaction, id, balance);
      emit(
        const TransactionSuccess([]),
      );
    } catch (e) {
      emit(
        TransactionFailed(
          e.toString(),
        ),
      );
    }
  }

  void fetchTransaction(String id) async {
    try {
      emit(TransactionLoading());
      List<TransactionModel> transactions =
          await TransactionService().fetchTransaction(id);
      emit(
        TransactionSuccess(transactions),
      );
    } catch (e) {
      emit(
        TransactionFailed(
          e.toString(),
        ),
      );
    }
  }
}
