import 'package:flutter/material.dart';

class AuthMethodSelection extends StatelessWidget {
  const AuthMethodSelection({Key? key}) : super(key: key);

  static const String route = '/auth-method-selection';

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
                    onPressed: () async {},
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
                    onPressed: () async {},
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
