import 'package:flutter/material.dart';
import 'package:repos_fetcher/screens/auth/auth_method_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:repos_fetcher/screens/auth/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/auth-method-selection',
      routes: {
        '/auth-method-selection': (context) => const AuthMethodSelection(),
        '/phone-auth': (context) => const PhoneAuthentication(),
      },
    );
  }
}
