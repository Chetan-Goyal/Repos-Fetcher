import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repos_fetcher/models/repo_details.dart';
import 'package:repos_fetcher/screens/auth/auth_method_selection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:repos_fetcher/screens/auth/phone_auth.dart';
import 'package:repos_fetcher/screens/home_page/home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RepoDetailsAdapter());
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
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: '/auth-method-selection',
      routes: {
        '/auth-method-selection': (context) => const AuthMethodSelection(),
        '/phone-auth': (context) => const PhoneAuthentication(),
        '/home-page': (context) => const HomePage(),
      },
    );
  }
}
