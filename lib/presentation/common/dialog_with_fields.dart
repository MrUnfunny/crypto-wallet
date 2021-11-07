import 'package:cryptowallet/constant/currency.dart';
import 'package:cryptowallet/models/expense.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/models/currency.dart';
import 'package:cryptowallet/models/income.dart';

void showDialogWithFields(BuildContext context, bool isIncome) {
  showDialog(
    context: context,
    builder: (_) {
      var currency = 'bitcoin';
      var amountController = TextEditingController();
      var sourceController = TextEditingController();
      var dateController =
          TextEditingController(text: DateTime.now().toString());
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        backgroundColor: ThemeColors.backgroundColor,
        title: Text(isIncome ? Constants.addIncome : Constants.addExpense),
        content: SizedBox(
          height: 250,
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: ThemeColors.lightMainAccentColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        dropdownColor: ThemeColors.mainColor,
                        value: 'bitcoin',
                        onChanged: (value) {
                          if (value != null) {
                            currency = value;
                          }
                        },
                        items: crypto.keys
                            .toList()
                            .map((key) => DropdownMenuItem<String>(
                                  child: Text(crypto[key]!),
                                  value: key,
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        validator: (String? val) {
                          if (val != null) {
                            if (int.tryParse(val) == null) {
                              return 'Input can only be integer';
                            }
                          }
                        },
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: Constants.amount,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: ThemeColors.lightMainAccentColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: sourceController,
                  decoration: InputDecoration(
                    hintText: Constants.source,
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: ThemeColors.textPrimaryLightColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: ThemeColors.lightMainAccentColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DateTimePicker(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: Constants.date,
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ThemeColors.textPrimaryLightColor,
                        ),
                  ),
                  autocorrect: false,
                  // initialValue: DateTime.now().toString(),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime.now(),
                  dateLabelText: 'Date',
                  validator: (val) {},
                  onSaved: (val) {},
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              Constants.cancel,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ThemeColors.textPrimaryLightColor,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (isIncome) {
                context.read<FirestoreBloc>().add(
                      FirestoreAddIncomeEvent(
                        Income(
                          Currency(
                            currency,
                            curr[currency]!,
                            crypto[currency]!,
                            0,
                            0,
                          ),
                          double.tryParse(amountController.text)!,
                          sourceController.text,
                          DateTime.parse(dateController.text),
                        ),
                      ),
                    );

                context
                    .read<FirestoreBloc>()
                    .add(FirestoreGetAllIncomesEvent());
              } else {
                context.read<FirestoreBloc>().add(
                      FirestoreAddExpenseEvent(
                        Expense(
                          Currency(
                            currency,
                            curr[currency]!,
                            crypto[currency]!,
                            0,
                            0,
                          ),
                          double.tryParse(amountController.text)!,
                          sourceController.text,
                          DateTime.parse(dateController.text),
                        ),
                      ),
                    );

                context
                    .read<FirestoreBloc>()
                    .add(FirestoreGetAllExpensesEvent());
              }

              Navigator.pop(context);
            },
            child: Text(
              Constants.send,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ThemeColors.textPrimaryLightColor,
                  ),
            ),
          ),
        ],
      );
    },
  );
}
