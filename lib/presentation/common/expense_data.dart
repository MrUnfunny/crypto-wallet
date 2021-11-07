import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/models/user_data.dart';
import 'package:cryptowallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_bottom_nav_bar.dart';

class ExpenseData extends StatelessWidget {
  final String name;
  final UserData userData;

  const ExpenseData({Key? key, required this.name, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('called $name\n');
    return Container(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavItems(
                icon: const Icon(
                  FontAwesomeIcons.ethereum,
                  color: Color(0xff555FEB),
                ),
                onTap: () {},
                colors: const [
                  Color(0xff7037C9),
                  Color(0xff9B68EB),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                '${capitalize(name)} ${Constants.balance}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: ThemeColors.lightMainAccentColor),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                getBalance(userData, name) < 0
                    ? '-\$' +
                        (-1 * getBalance(userData, name)).toStringAsFixed(2)
                    : '\$' + getBalance(userData, name).toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.bullseye,
                        size: 16,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Constants.daily,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    getWeeklyData(userData, name).toStringAsFixed(2) + '\$',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.bullseye,
                        size: 16,
                        color: Color(0xff612FF5),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Constants.monthly,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    getMonthlyData(userData, name).toStringAsFixed(2) + '\$',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

double getMonthlyData(UserData userData, String name) {
  final date = userData.expense.last.time;

  double balance = 0;

  for (var element in userData.incomes) {
    if (element.time.difference(date) < const Duration(days: 31) &&
        element.currency.name == name) {
      balance += element.amount * userData.conversionRate[name]!.usd;
    }
  }

  for (var element in userData.expense) {
    if (element.time.difference(date) < const Duration(days: 31) &&
        element.currency.name == name) {
      balance -= element.amount * userData.conversionRate[name]!.usd;
    }
  }

  return balance;
}

double getWeeklyData(UserData userData, String name) {
  final date = userData.expense.last.time;

  double balance = 0;

  for (var element in userData.incomes) {
    if (element.time.difference(date) < const Duration(days: 8) &&
        element.currency.name == name) {
      balance += element.amount * userData.conversionRate[name]!.usd;
    }
  }

  for (var element in userData.expense) {
    if (element.time.difference(date) < const Duration(days: 8) &&
        element.currency.name == name) {
      balance -= element.amount * userData.conversionRate[name]!.usd;
    }
  }

  return balance;
}

double getBalance(UserData userData, String name) {
  double balance = 0;
  for (var element in userData.incomes) {
    if (element.currency.name == name) {
      balance += element.amount * userData.conversionRate[name]!.usd;
    }
  }

  for (var element in userData.expense) {
    if (element.currency.name == name) {
      balance -= element.amount * userData.conversionRate[name]!.usd;
    }
  }

  return balance;
}
