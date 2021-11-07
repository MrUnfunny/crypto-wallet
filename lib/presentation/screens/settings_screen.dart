import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/presentation/common/custom_bottom_nav_bar.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                Constants.setting,
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
      ),
    );
  }
}
