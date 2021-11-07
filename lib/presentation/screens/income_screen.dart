import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/presentation/common/dialog_with_fields.dart';
import 'package:flutter/material.dart';

import 'package:cryptowallet/presentation/common/custom_bottom_nav_bar.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FirestoreBloc>().add(FirestoreGetAllIncomesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<FirestoreBloc, FirestoreState>(
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
                          Constants.income,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_rounded),
                          onPressed: () => showDialogWithFields(context, true),
                        )
                      ],
                    ),
                  ),
                  ...(state)
                      .userData
                      .incomes
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: FullCard(
                            income: e,
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
