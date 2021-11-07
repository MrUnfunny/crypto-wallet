import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/presentation/screens/expense_home_screen.dart';
import 'package:cryptowallet/presentation/screens/expense_screen.dart';
import 'package:cryptowallet/presentation/screens/income_screen.dart';
import 'package:cryptowallet/presentation/screens/loading_screen.dart';
import 'package:cryptowallet/presentation/screens/main_screen.dart';
import 'package:cryptowallet/presentation/screens/home_screen.dart';
import 'package:cryptowallet/presentation/screens/settings_screen.dart';
import 'package:cryptowallet/presentation/screens/sign_in_screen.dart';
import 'package:cryptowallet/presentation/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case RoutePaths.loadingScreen:
            return const LoadingScreen();

          case RoutePaths.mainScreen:
            return const MainScreen();

          case RoutePaths.signUpScreen:
            return const SignUpScreen();

          case RoutePaths.signInScreen:
            return const SignInScreen();

          case RoutePaths.homeScreen:
            return const HomeScreen();

          case RoutePaths.settingsScreen:
            return const SettingsScreen();

          case RoutePaths.incomeScreen:
            return const IncomeScreen();

          case RoutePaths.expenseScreen:
            return const ExpenseScreen();

          case RoutePaths.expenseHomeScreen:
            return const ExpenseHomeScreen();

          default:
            if (FirebaseAuth.instance.currentUser == null) {
              return const MainScreen();
            }
            return const HomeScreen();
        }
      });
}
