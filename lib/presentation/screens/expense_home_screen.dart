import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/currency.dart';
import 'package:cryptowallet/presentation/common/custom_bottom_nav_bar.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:cryptowallet/presentation/common/expense_chart.dart';
import 'package:cryptowallet/presentation/common/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseHomeScreen extends StatefulWidget {
  const ExpenseHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseHomeScreen> createState() => _ExpenseHomeScreenState();
}

class _ExpenseHomeScreenState extends State<ExpenseHomeScreen> {
  String _activeCrypto = 'ethereum';
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 30,
        ),
        child: SafeArea(
          child: BlocBuilder<FirestoreBloc, FirestoreState>(
            builder: (context, state) {
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          Constants.overview,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: ThemeColors.mainColor,
                          ),
                          padding: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: ThemeColors.mainColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: ThemeColors.iconLightColor,
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff535B85),
                                        Color(0xff43496A),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: ThemeColors.iconLightColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExpenseData(
                    name: _activeCrypto,
                    userData: state.userData,
                  ),
                  ExpenseChart(
                    name: _activeCrypto,
                    expenses: state.userData.expense,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 18,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              Constants.daily,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 18),
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
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 18,
                          ),
                          height: 48,
                          alignment: Alignment.center,
                          child: Text(
                            Constants.weekly,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 18),
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
                        )),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 18,
                            ),
                            height: 48,
                            alignment: Alignment.center,
                            child: Text(
                              Constants.monthly,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 18),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<FirestoreBloc, FirestoreState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: const LinearGradient(colors: [
                              Color(0xff484F75),
                              Color(0xff383E5E),
                            ])),
                        child: Column(
                          children: crypto.keys
                              .map(
                                (e) => Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _activeCrypto = e;
                                        });
                                      },
                                      child: CryptoDetailCard(
                                        name: e,
                                        conversionRate: state
                                            .userData.conversionRate[e]?.usd,
                                      ),
                                    ),
                                    if (e != crypto.keys.last)
                                      Container(
                                        height: 4,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: <Color>[
                                              const Color(0xff5A6086),
                                              const Color(0xff5A6086)
                                                  .withOpacity(0.4),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CryptoDetailCard extends StatelessWidget {
  final double? conversionRate;
  final String name;
  const CryptoDetailCard(
      {Key? key, required this.name, required this.conversionRate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavItems(
            icon: Icon(
              curr[name],
            ),
            onTap: () {},
            colors: const [
              Color(0xffD2D6EF),
              Color(0xff9299C2),
            ],
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(crypto[name]! + ' / USD'),
              const SizedBox(
                height: 6,
              ),
              Text(
                conversionRate?.toStringAsFixed(2) ?? '0',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: ThemeColors.lightMainAccentColor),
              )
            ],
          ),
          const Spacer(),
          Text(
            conversionRate?.toStringAsFixed(2) ?? '0',
          ),
        ],
      ),
    );
  }
}
