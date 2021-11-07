import 'dart:convert';

import 'currency.dart';

class Expense {
  final Currency currency;
  final double amount;
  final String reason;
  final DateTime time;

  Expense(
    this.currency,
    this.amount,
    this.reason,
    this.time,
  );

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'reason': reason,
      'currency': currency.name,
      'time': time.millisecondsSinceEpoch,
      'icon': currency.code,
      'code': currency.code,
      'usdPrice': currency.usdPrice,
      'inrPrice': currency.inrPrice,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      Currency.fromMap({
        'name': map['currency'],
        'icon': map['icon'],
        'code': map['code'],
        'usdPrice': map['usdPrice'],
        'inrPrice': map['inrPrice']
      }),
      map['amount'],
      map['reason'],
      DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source));
}
