import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/presentation/common/dialog_with_fields.dart';
import 'package:flutter/material.dart';

import 'package:cryptowallet/presentation/common/custom_bottom_nav_bar.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FirestoreBloc>().add(FirestoreGetAllExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocConsumer<FirestoreBloc, FirestoreState>(
        listener: (context, state) {
          if (state is FirestoreIllegalExpenseState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: ThemeColors.mainColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const CircularProgressIndicator();
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Constants.expense,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_rounded),
                          onPressed: () => showDialogWithFields(context, false),
                        )
                      ],
                    ),
                  ),
                  ...(state)
                      .userData
                      .expense
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: FullCard(
                            expense: e,
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
