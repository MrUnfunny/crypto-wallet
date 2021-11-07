import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/constant/currency.dart';
import 'package:cryptowallet/models/expense.dart';
import 'package:cryptowallet/models/income.dart';
import 'package:cryptowallet/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FirestoreRepository {
  FirestoreRepository._() : firestoreInstance = FirebaseFirestore.instance;

  factory FirestoreRepository() => _instance;

  FirebaseFirestore firestoreInstance;
  static final FirestoreRepository _instance = FirestoreRepository._();

  void addUser() {
    firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('username')
        .set(
      {
        'username': FirebaseAuth.instance.currentUser!.displayName,
      },
    );
  }

  Future<void> addIncome(Income income) async {
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('income')
        .collection('list')
        .add(
      {
        income.currency.name: income.toJson(),
      },
    );
  }

  Future<void> addExpense(Expense expense) async {
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('expense')
        .collection('list')
        .add(
      {
        expense.currency.name: expense.toJson(),
      },
    );
  }

  Future<void> removeIncome(Income income) async {
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('income')
        .collection('list')
        .where(income.currency.name, isEqualTo: income.toJson())
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              firestoreInstance
                  .collection(FirebaseAuth.instance.currentUser!.uid)
                  .doc('income')
                  .collection('list')
                  .doc(element.id)
                  .delete();
            },
          ),
        );
  }

  Future<void> removeExpense(Expense expense) async {
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('expense')
        .collection('list')
        .where(expense.currency.name, isEqualTo: expense.toJson())
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              firestoreInstance
                  .collection(FirebaseAuth.instance.currentUser!.uid)
                  .doc('expense')
                  .collection('list')
                  .doc(element.id)
                  .delete();
            },
          ),
        );
  }

  Future<List<Income>> getAllIncomes() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('income')
        .collection('list')
        .get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    var res = allData.map((element) {
      var r = element as Map<String, dynamic>;
      var currency = element.keys.toList().first;

      var result = Income.fromJson(r[currency]);
      return result;
    }).toList();

    res.sort((Income a, Income b) => a.time.compareTo(b.time));

    return res;
  }

  Future<List<Expense>> getAllExpenses() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('expense')
        .collection('list')
        .get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    var res = allData.map((element) {
      var r = element as Map<String, dynamic>;
      var currency = element.keys.toList().first;

      var result = Expense.fromJson(r[currency]);
      return result;
    }).toList();

    res.sort((Expense a, Expense b) => a.time.compareTo(b.time));

    return res;
  }

  Future<double> updateIncome() async {
    QuerySnapshot querySnapshot = await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('income')
        .collection('list')
        .get();

    double income = 0;

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in allData) {
      var r = element as Map<String, dynamic>;
      var data = jsonDecode(r[element.keys.toList().first]);

      income += data['amount'];
    }

    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('income')
        .set(
      {'amount': income},
    );

    return income;
  }

  Future<double> updateExpense() async {
    QuerySnapshot expenseQuerySnapshot = await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('expense')
        .collection('list')
        .get();

    double expense = 0;

    final allData = expenseQuerySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in allData) {
      var r = element as Map<String, dynamic>;
      var data = jsonDecode(r[element.keys.toList().first]);

      expense += data['amount'];
    }

    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('expense')
        .set(
      {'amount': expense},
    );

    return expense;
  }

  Future<UserData?> getAllUserData() async {
    double income = 0;
    double expense = 0;
    List<Income> incomeList;
    List<Expense> expenseList;

    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }

    final conversionRates = await getCoinPrices();

    final QuerySnapshot incomeQuerySnapshot = await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('income')
        .collection('list')
        .get();

    final allIncomeData =
        incomeQuerySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in allIncomeData) {
      var r = element as Map<String, dynamic>;
      var data = jsonDecode(r[element.keys.toList().first]);

      income +=
          data['amount'] * conversionRates[element.keys.toList().first]!.usd;
    }

    final QuerySnapshot expenseQuerySnapshot = await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('expense')
        .collection('list')
        .get();

    final allExpenseData =
        expenseQuerySnapshot.docs.map((doc) => doc.data()).toList();
    for (var element in allExpenseData) {
      var r = element as Map<String, dynamic>;
      var data = jsonDecode(r[element.keys.toList().first]);

      expense +=
          data['amount'] * conversionRates[element.keys.toList().first]!.usd;
    }

    incomeList = allIncomeData.map((element) {
      var r = element as Map<String, dynamic>;
      var currency = element.keys.toList().first;

      var result = Income.fromJson(r[currency]);
      return result;
    }).toList();

    expenseList = allExpenseData.map((element) {
      var r = element as Map<String, dynamic>;
      var currency = element.keys.toList().first;

      var result = Expense.fromJson(r[currency]);
      return result;
    }).toList();

    incomeList.sort((Income a, Income b) => a.time.compareTo(b.time));
    expenseList.sort((Expense a, Expense b) => a.time.compareTo(b.time));

    return UserData(
      FirebaseAuth.instance.currentUser!.displayName!,
      income,
      expense,
      incomeList,
      expenseList,
      conversionRates,
    );
  }

  Future<Map<String, ConvertedCurrency>> getCoinPrices() async {
    // _coinGecko.simplePrice(
    //     ids: ['bitcoin', 'ethereum', 'dogecoin', 'tether', 'ripple'],
    //     vs_currencies: ['inr', 'usd']);
    final res = await http.get(
      Uri.parse(
          'http://api.coinlayer.com/live?access_key=586cd30c55b489ecfb274419cba7b289'),
      headers: {'accept': 'application/json'},
    );

    final result = jsonDecode(res.body)['rates'];

    final Map<String, ConvertedCurrency> convertedCurrency = {};

    for (var i in crypto.keys) {
      convertedCurrency[i] = (ConvertedCurrency(0, result[crypto[i]]));
    }

    return convertedCurrency;
  }
}
