import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/repository/firestore_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cryptowallet/bloc/auth/auth_bloc.dart';
import 'package:cryptowallet/config/theme.dart';
import 'package:cryptowallet/constant/constants.dart';
import 'package:cryptowallet/constant/route_paths.dart';
import 'package:cryptowallet/constant/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreRepository();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => FirestoreBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        onGenerateRoute: router.generateRoutes,
        initialRoute: RoutePaths.loadingScreen,
        theme: themeData(
          ThemeData.light(),
        ),
      ),
    );
  }
}
