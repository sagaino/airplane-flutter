import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/theme.dart';
import 'package:airplane/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    context.read<TransactionCubit>().fetchTransaction(user!.uid);
    context.read<AuthCubit>().getCurrentUser(user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionSuccess) {
          if (state.transactions.isEmpty) {
            return const Center(
              child: Text("Tidak ada Transaksi"),
            );
          } else {
            return ListView.builder(
              itemCount: state.transactions.length,
              padding: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: 110,
              ),
              itemBuilder: (BuildContext context, index) {
                var item = state.transactions[index];
                return TransactionCard(item);
              },
            );
          }
        }
        return const Center(
          child: Text("Transaction Page"),
        );
      },
    );
  }
}
