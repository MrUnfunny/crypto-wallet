import 'dart:convert';

import 'package:cryptowallet/constant/constants.dart';

import 'expense.dart';
import 'income.dart';

class UserData {
  final String username;
  final double totalIncome;
  final double totalExpense;
  final List<Income> incomes;
  final List<Expense> expense;
  final Map<String, ConvertedCurrency> conversionRate;

  UserData(
    this.username,
    this.totalIncome,
    this.totalExpense,
    this.incomes,
    this.expense,
    this.conversionRate,
  );

  factory UserData.empty() {
    return UserData(
      '',
      1,
      0,
      [],
      [],
      Constants.defaultConversionRate,
    );
  }

  @override
  String toString() {
    return 'UserData(username: $username, totalIncome: $totalIncome, totalExpense: $totalExpense, incomes: $incomes, expense: $expense)';
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'incomes': incomes.map((x) => x.toMap()).toList(),
      'expense': expense.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      map['username'],
      map['totalIncome'],
      map['totalExpense'],
      List<Income>.from(map['incomes']?.map((x) => Income.fromMap(x))),
      List<Expense>.from(map['expense']?.map((x) => Expense.fromMap(x))),
      Constants.defaultConversionRate,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  UserData copyWith({
    String? username,
    double? totalIncome,
    double? totalExpense,
    List<Income>? incomes,
    List<Expense>? expense,
    Map<String, ConvertedCurrency>? conversionRate,
  }) {
    return UserData(
      username ?? this.username,
      totalIncome ?? this.totalIncome,
      totalExpense ?? this.totalExpense,
      incomes ?? this.incomes,
      expense ?? this.expense,
      conversionRate ?? this.conversionRate,
    );
  }
}

class ConvertedCurrency {
  double inr;
  double usd;
  ConvertedCurrency(
    this.inr,
    this.usd,
  );

  @override
  String toString() => 'ConvertedCurrency(inr: $inr, usd: $usd)';
}
