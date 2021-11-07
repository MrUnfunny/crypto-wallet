import 'package:cryptowallet/bloc/auth/auth_bloc.dart';
import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/presentation/common/custom_bottom_nav_bar.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:cryptowallet/presentation/common/line_chart.dart';
import 'package:cryptowallet/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          Navigator.pushReplacementNamed(context, RoutePaths.mainScreen);
        }
      },
      child: CustomScaffold(
        bottomNavigationBar: const CustomNavBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Constants.hello,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            TextSpan(
                              text: userRepository.getUser()?.displayName ??
                                  userRepository.getUser()?.email,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                      ),
                      NavItems(
                        icon: Icon(
                          Icons.logout,
                          color: ThemeColors.iconLightColor,
                        ),
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogOutEvent());
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<FirestoreBloc, FirestoreState>(
                  builder: (context, state) {
                    if (state.userData.expense.isNotEmpty) {
                      return const LineChartSample1();
                    } else {
                      return Container(
                          height: 320,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: ThemeColors.backgroundColor,
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff2D334E),
                                const Color(0xff30354F).withOpacity(0.0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF495073),
                                offset: Offset(-12, -12),
                                blurRadius: 32,
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Color(0xFF2E334E),
                                offset: Offset(12, 12),
                                blurRadius: 32,
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Color(0xFF535C88),
                                offset: Offset(2, 2),
                                blurRadius: 1,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Add Incomes and Expenses to Continue',
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: ThemeColors.textPrimaryLightColor
                                          .withOpacity(0.3),
                                    ),
                          ));
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Constants.balance,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.left,
                    ),
                    BlocBuilder<FirestoreBloc, FirestoreState>(
                      builder: (context, state) {
                        return Text(
                          '\$ ' +
                              (state.userData.totalIncome -
                                      state.userData.totalExpense)
                                  .toStringAsFixed(2),
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: ThemeColors.lightMainAccentColor,
                                  ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: BlocBuilder<FirestoreBloc, FirestoreState>(
                    builder: (context, state) {
                      return StepProgressIndicator(
                        totalSteps: state.userData.totalIncome.floor() == 0
                            ? 1
                            : state.userData.totalIncome.floor(),
                        currentStep: (state.userData.totalIncome >
                                state.userData.totalExpense)
                            ? (state.userData.totalIncome -
                                    state.userData.totalExpense)
                                .floor()
                            : 0,
                        size: 20,
                        padding: 0,
                        selectedColor: ThemeColors.progressStartColor,
                        unselectedColor: ThemeColors.mainColor,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ThemeColors.progressStartColor,
                            ThemeColors.progressEndColor,
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<FirestoreBloc, FirestoreState>(
                      builder: (context, state) {
                        return LargeItems(
                          icon: const Icon(
                            FontAwesomeIcons.angleDown,
                            color: Color(0xff2F9BFF),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutePaths.incomeScreen,
                            );
                          },
                          title: Constants.income,
                          data: state.userData.totalIncome,
                        );
                      },
                    ),
                    BlocBuilder<FirestoreBloc, FirestoreState>(
                      builder: (context, state) {
                        return LargeItems(
                          icon: const Icon(
                            FontAwesomeIcons.angleUp,
                            color: Color(0xffF47169),
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            RoutePaths.expenseScreen,
                          ),
                          title: Constants.expense,
                          data: state.userData.totalExpense,
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
