import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/presentation/common/custom_button.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  Constants.homeScreenTitle,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color:
                            ThemeColors.textPrimaryLightColor.withOpacity(0.3),
                      ),
                ),
                const Spacer(),
                CustomButton(
                  buttonText: Constants.signUpButtonText,
                  topMargin: 12,
                  filled: true,
                  onTap: () =>
                      Navigator.pushNamed(context, RoutePaths.signUpScreen),
                  fillColor: ThemeColors.buttonLightColor,
                ),
                CustomButton(
                  buttonText: Constants.signInButtonText,
                  topMargin: 12,
                  filled: false,
                  onTap: () =>
                      Navigator.pushNamed(context, RoutePaths.signInScreen),
                  fillColor: ThemeColors.buttonLightColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
