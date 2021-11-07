import 'dart:convert';

import 'currency.dart';

class Income {
  final Currency currency;
  final double amount;
  final String source;
  final DateTime time;

  Income(this.currency, this.amount, this.source, this.time);

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'source': source,
      'currency': currency.name,
      'time': time.millisecondsSinceEpoch,
      'icon': currency.code,
      'code': currency.code,
      'usdPrice': currency.usdPrice,
      'inrPrice': currency.inrPrice,
    };
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      Currency.fromMap({
        'name': map['currency'],
        'icon': map['icon'],
        'code': map['code'],
        'usdPrice': map['usdPrice'],
        'inrPrice': map['inrPrice']
      }),
      map['amount'],
      map['source'],
      DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Income.fromJson(String source) => Income.fromMap(json.decode(source));

  @override
  String toString() =>
      'Income(currency: $currency, amount: $amount, source: $source, time: $time)';
}
