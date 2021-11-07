import 'package:cryptowallet/config/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.topMargin,
    required this.fillColor,
    required this.filled,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final double topMargin;
  final bool filled;
  final Color fillColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320.0,
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
        ),
        margin: EdgeInsets.only(
          top: topMargin,
          bottom: 10.0,
        ),
        decoration: BoxDecoration(
          color: (filled) ? fillColor : null,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            style: BorderStyle.solid,
            color: (filled) ? fillColor : ThemeColors.textPrimaryLightColor,
          ),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: filled
              ? Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: ThemeColors.backgroundColor)
              : Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
