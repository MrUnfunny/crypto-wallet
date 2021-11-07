import 'dart:convert';

import 'package:cryptowallet/constant/currency.dart';
import 'package:flutter/material.dart';

class Currency {
  final String name;
  final String code;
  final double usdPrice;
  final double inrPrice;
  final IconData icon;

  Currency(this.name, this.icon, this.code, this.usdPrice, this.inrPrice);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': code,
      'code': code,
      'usdPrice': usdPrice,
      'inrPrice': inrPrice,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      map['name'],
      curr['icon'] ?? Icons.ac_unit_rounded,
      map['code'],
      map['usdPrice'],
      map['inrPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));
}
