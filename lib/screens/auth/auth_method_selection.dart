import 'package:flutter/material.dart';
import 'package:repos_fetcher/services/auth/biometric_auth.dart';

class AuthMethodSelection extends StatefulWidget {
  const AuthMethodSelection({Key? key}) : super(key: key);

  static const String route = '/auth-method-selection';

  @override
  State<AuthMethodSelection> createState() => _AuthMethodSelectionState();
}

class _AuthMethodSelectionState extends State<AuthMethodSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/auth_options_bg.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(child: Container(color: Colors.black.withOpacity(0.3))),
          Positioned(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Image.asset("assets/logo.png")),
          ),
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 30.0,
                  child: OutlineButton.icon(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 3,
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: const Icon(Icons.account_circle),
                    label: const Text("Continue with Biometric"),
                    onPressed: () async {
                      if (await BiometricAuth().isBiometricPresent()) {
                        await BiometricAuth().isConfirmed();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 30.0,
                  child: OutlineButton.icon(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 3,
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: const Icon(Icons.perm_phone_msg_outlined),
                    label: const Text("Continue with Phone Number"),
                    onPressed: () async {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/phone-auth', (route) => false);
                    },
                  ),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            bottom: 50,
          ),
        ],
      ),
    );
  }
}
