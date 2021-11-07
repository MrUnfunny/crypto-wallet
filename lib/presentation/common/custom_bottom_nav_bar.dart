import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/currency.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/models/expense.dart';
import 'package:cryptowallet/models/income.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      color: ThemeColors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavItems(
            icon: Icon(
              Icons.dashboard,
              color: ThemeColors.iconLightColor,
            ),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name !=
                  RoutePaths.homeScreen) {
                Navigator.pushNamed(context, RoutePaths.homeScreen);
              }
            },
          ),
          NavItems(
            icon: Icon(
              Icons.swap_vert_rounded,
              color: ThemeColors.iconLightColor,
            ),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name !=
                  RoutePaths.expenseHomeScreen) {
                Navigator.pushReplacementNamed(
                    context, RoutePaths.expenseHomeScreen);
              }
            },
          ),
          NavItems(
            icon: Icon(
              FontAwesomeIcons.wallet,
              color: ThemeColors.iconLightColor,
            ),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name !=
                  RoutePaths.incomeScreen) {
                Navigator.pushNamed(context, RoutePaths.incomeScreen);
              }
            },
          ),
          NavItems(
            icon: Icon(
              Icons.settings,
              color: ThemeColors.iconLightColor,
            ),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name !=
                  RoutePaths.settingsScreen) {
                Navigator.pushNamed(context, RoutePaths.settingsScreen);
              }
            },
          ),
        ],
      ),
    );
  }
}

class NavItems extends StatelessWidget {
  final Icon icon;
  final void Function() onTap;
  final List<Color>? colors;
  final double? size;
  const NavItems({
    Key? key,
    required this.icon,
    required this.onTap,
    this.size,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors ??
                  const <Color>[
                    Color(0xff9299C2),
                    Color(0xffD2D6EF),
                  ],
            ).createShader(bounds);
          },
          child: icon,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size == null ? 18 : 12),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF555D83),
              offset: Offset(-6.0, -6.0),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Color(0xFF363B57),
              offset: Offset(8.0, 8.0),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5F6791),
              Color(0xFF272C43),
            ],
            stops: [0.1, 1],
          ),
        ),
        height: size ?? 60,
        width: size ?? 60,
      ),
    );
  }
}

class LargeItems extends StatelessWidget {
  final Icon icon;
  final String title;
  final double data;
  final void Function() onTap;
  const LargeItems(
      {Key? key,
      required this.icon,
      required this.onTap,
      required this.title,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            NavItems(
              icon: icon,
              onTap: () {},
              size: 43,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: ThemeColors.lightMainAccentColor),
                ),
                Text('\$ ' + data.toStringAsFixed(2)),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF555D83),
              offset: Offset(-6.0, -6.0),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Color(0xFF363B57),
              offset: Offset(8.0, 8.0),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5F6791),
              Color(0xFF272C43),
            ],
            stops: [0.1, 1],
          ),
        ),
        height: 70,
        width: 170,
      ),
    );
  }
}

class FullCard extends StatelessWidget {
  final Income? income;
  final Expense? expense;

  const FullCard({
    Key? key,
    this.income,
    this.expense,
  })  : assert((income == null) ^ (expense == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(DateTime.now().toString()),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        if (income != null) {
          context
              .read<FirestoreBloc>()
              .add(FirestoreRemoveIncomeEvent(income!));
        } else {
          context
              .read<FirestoreBloc>()
              .add(FirestoreRemoveExpenseEvent(expense!));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(expense != null
                ? curr[expense!.currency.name]
                : curr[income!.currency.name]),
            const SizedBox(
              width: 4,
            ),
            Text(
              expense != null
                  ? expense!.amount.toStringAsFixed(2)
                  : income!.amount.toStringAsFixed(2),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ThemeColors.lightMainAccentColor),
            ),
            const SizedBox(
              width: 18,
            ),
            Text(expense != null ? expense!.reason : income!.source),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF555D83),
              offset: Offset(-6.0, -6.0),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Color(0xFF363B57),
              offset: Offset(8.0, 8.0),
              blurRadius: 20.0,
              spreadRadius: 0.0,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5F6791),
              Color(0xFF272C43),
            ],
            stops: [0.1, 1],
          ),
        ),
        height: 70,
      ),
    );
  }
}
