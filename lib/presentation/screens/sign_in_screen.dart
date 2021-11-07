import 'package:cryptowallet/bloc/auth/auth_bloc.dart';
import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/presentation/common/custom_textfield.dart';
import 'package:cryptowallet/utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          context
              .read<FirestoreBloc>()
              .add(const FirestoreUpdateUserDataEvent());
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
                      children: [
                        Text(
                          Constants.signInScreenTitle,
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
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   padding: const EdgeInsets.only(
                        //     right: 6.0,
                        //     top: 10.0,
                        //   ),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       if (email.isEmpty) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           const SnackBar(
                        //             content: Text(
                        //               Constants.emailForResettingPassword,
                        //             ),
                        //           ),
                        //         );
                        //       } else {
                        //         FirebaseAuth.instance
                        //             .sendPasswordResetEmail(email: email);
                        //       }
                        //     },
                        //     child: const Text(
                        //       Constants.forgotPassword,
                        //       textAlign: TextAlign.end,
                        //     ),
                        //   ),
                        // ),
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
                            if (Email.validate(email) &&
                                Password.validate(password)) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthLoginEvent(email, password));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(Constants.authenticationError),
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state.loading) {
                                return const CircularProgressIndicator();
                              } else {
                                return Text(
                                  Constants.signInButtonText,
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
