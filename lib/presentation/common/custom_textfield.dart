import 'package:flutter/material.dart';
import 'package:cryptowallet/config/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
    this.onChanged,
    this.icon,
    this.inputType,
    this.isPassword,
    this.text, {
    this.validator,
    this.errorText,
    Key? key,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final TextInputType inputType;
  final bool isPassword;
  final Function onChanged;
  final bool Function(String)? validator;
  final String? errorText;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool iconVisibility = false;
  bool visibleIcon = false;

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.clear();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ThemeColors.lightMainAccentColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          widget.onChanged(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.text,
          hintStyle: Theme.of(context).textTheme.headline6,
          errorText: (widget.validator != null &&
                  !((widget.validator != null)
                      ? widget.validator!(controller.text)
                      : false))
              ? widget.errorText
              : null,
          prefixIcon: widget.icon,
          suffix: (iconVisibility)
              ? (visibleIcon)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          visibleIcon = !visibleIcon;
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                        color: ThemeColors.textPrimaryLightColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          visibleIcon = !visibleIcon;
                        });
                      },
                      child: Icon(
                        Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
              : null,
        ),
        keyboardType: widget.inputType,
        obscureText: (widget.isPassword)
            ? (visibleIcon)
                ? false
                : true
            : false,
        onTap: () {
          setState(() {
            if (widget.isPassword == true) {
              iconVisibility = true;
            }
          });
        },
      ),
    );
  }
}
