import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({Key? key}) : super(key: key);

  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  String? phoneNumber, verificationId;
  String? otp;
  String authStatus = "";
  final _formKey = GlobalKey<FormState>();

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phoneNumber!,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, count) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        otpDialogBox(context);
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              title: const Text('Enter your OTP'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      otp = value;
                    },
                    validator: (val) {
                      if (val == null || val == "") {
                        return "Please enter your otp";
                      }
                      if (val.length != 6) {
                        return "Please enter a valid otp";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.all(13.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signIn(otp!).then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                  child: Container(
                    child: const Text(
                      'Verify',
                    ),
                  ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }

  Future<bool> signIn(String otp) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      ));
      return true;
    } catch (e) {
      authStatus =
          (e as FirebaseAuthException).message ?? "Unable to Verify Otp";
      Navigator.of(context).pop();
      setState(() {});
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/auth_options_bg.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(child: Container(color: Colors.black.withOpacity(0.3))),
          Positioned(
            top: 100,
            width: MediaQuery.of(context).size.width,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Continue with Phone Number",
                style: TextStyle(
                  color: Colors.red, //Color.fromRGBO(82, 117, 90, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Image.asset("assets/logo.png")),
          ),
          Positioned(
            bottom: 30,
            // height: MediaQuery.of(context).size.height - 50,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    authStatus,
                    style: TextStyle(
                        color: authStatus.contains("fail") ||
                                authStatus.contains("TIMEOUT")
                            ? Colors.red
                            : Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          filled: true,
                          prefixText: "+91    ",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Enter Your Phone Number...",
                          fillColor: Colors.white70),
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: deprecated_member_use
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 40.0,
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
                      label: const Text("Send OTP"),
                      onPressed: () =>
                          phoneNumber == null || phoneNumber!.length != 10
                              ? null
                              : verifyPhoneNumber(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
