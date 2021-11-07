import 'package:cryptowallet/models/user_data.dart';

class Constants {
  static const String appName = 'Crypto Wallet';

  static const String signUpButtonText = 'SIGN UP';
  static const String signInButtonText = 'SIGN IN';
  static const String signUpScreenTitle = 'Account \nSignup';
  static const String signInScreenTitle = 'Account \nSignin';
  static const String homeScreenTitle =
      'Please \nSignin \nOr \nSignup \nto Continue';

  static const String email = 'Email';
  static const String name = 'Name';
  static const String password = 'Password';
  static const String shortName = 'Name should be atleast 3 characters long';
  static const String invalidEmail = 'Invalid Email';
  static const String forgotPassword = 'Forgot Password';
  static const String emailForResettingPassword =
      'Enter Email Id for resetting password';
  static const String authenticationError =
      'Please enter valid Email and Password';

  static const String setting = 'Setting';

  static const String overview = 'Overview';
  static const String daily = 'Daily';
  static const String weekly = 'Weekly';
  static const String monthly = 'Monthly';

  static const String hello = 'Hello\n';
  static const String balance = 'Balance';
  static const String income = 'Income';
  static const String expense = 'Expense';

  static const String addIncome = 'Add Income';
  static const String addExpense = 'Add Expense';

  static const String cancel = 'Cancel';
  static const String send = 'Send';
  static const String source = 'Source';
  static const String amount = 'Amount';
  static const String date = 'Date';

  static final defaultConversionRate = {
    'bitcoin': ConvertedCurrency(0, 62522.63),
    'ethereum': ConvertedCurrency(0, 4620.03),
    'tether': ConvertedCurrency(0, 0.27),
    'dogecoin': ConvertedCurrency(0, 1.00),
    'ripple': ConvertedCurrency(0, 1.23),
  };
}
