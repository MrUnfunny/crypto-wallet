import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryptowallet/bloc/auth/auth_bloc.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/presentation/common/custom_textfield.dart';
import 'package:cryptowallet/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '', password = '', username = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
        }

        if (state is AuthFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: ThemeColors.mainColor,
            ),
          );
        }
      },
      child: CustomScaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraint.maxHeight - 60),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Constants.signUpScreenTitle,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: ThemeColors.textPrimaryLightColor
                                        .withOpacity(0.3),
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        CustomTextField(
                          (String value) {
                            setState(() {
                              username = value;
                            });
                          },
                          Icon(
                            FontAwesomeIcons.user,
                            color: ThemeColors.textPrimaryLightColor,
                          ),
                          TextInputType.text,
                          false,
                          Constants.name,
                          validator: ((String? value) {
                            if (value != null) {
                              return Username.validate(username);
                            } else {
                              return true;
                            }
                          }),
                          errorText: Constants.shortName,
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        CustomTextField(
                          (String value) {
                            setState(() {
                              email = value;
                            });
                          },
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: ThemeColors.textPrimaryLightColor,
                          ),
                          TextInputType.emailAddress,
                          false,
                          Constants.email,
                          validator: (String? value) {
                            if (value != null) return Email.validate(value);
                            return true;
                          },
                          errorText: Constants.invalidEmail,
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        CustomTextField(
                          (String value) {
                            setState(() {
                              password = value;
                            });
                          },
                          Icon(
                            FontAwesomeIcons.lock,
                            color: ThemeColors.textPrimaryLightColor,
                          ),
                          TextInputType.visiblePassword,
                          true,
                          Constants.password,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              ThemeColors.buttonLightColor,
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                vertical: 18.0,
                                horizontal: 98.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (Email.validate(email, allowEmpty: false) &&
                                Password.validate(password,
                                    allowEmpty: false) &&
                                Username.validate(username,
                                    allowEmpty: false)) {
                              context.read<AuthBloc>().add(
                                    AuthRegisterEvent(
                                        email, password, username),
                                  );
                            } else {
                              if (!Username.validate(
                                username,
                                allowEmpty: false,
                              )) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      Constants.shortName,
                                    ),
                                    backgroundColor: ThemeColors.mainColor,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      Constants.authenticationError,
                                    ),
                                    backgroundColor: ThemeColors.mainColor,
                                  ),
                                );
                              }
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state.loading) {
                                return const CircularProgressIndicator();
                              } else {
                                return Text(
                                  Constants.signUpButtonText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: ThemeColors.backgroundColor,
                                      ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
