import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/presentation/common/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FirestoreBloc>().add(const FirestoreUpdateUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirestoreBloc, FirestoreState>(
      listener: (context, state) {
        if (state is FirestoreAuthorizedState) {
          Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
        }

        if (state is FirestoreUnauthorizedState) {
          Navigator.pushReplacementNamed(context, RoutePaths.mainScreen);
        }
      },
      child: CustomScaffold(
        body: SizedBox(
          height: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const FlutterLogo(
                    size: 80,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(Constants.appName),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.lightMainAccentColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
