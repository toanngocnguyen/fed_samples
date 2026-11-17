import 'package:flutter/material.dart';
import 'package:fedfer/view.dart';
import 'package:fed_auth/auth.dart';

import 'login_view.dart';

class LoginCode extends FedViewCode {
  @override
  LoginView createView(FedViewCode code) => LoginView(key: UniqueKey(), code: code);

  final formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  bool checkLogin() {
    if (email == null || password == null) return false;

    debugPrint('email: $email');
    debugPrint('password: $password');

    Authentication().loginWithPassword(email: email!, password: password!);
    return Authentication().isLogined;
  }


  void onNext(BuildContext context) {
    debugPrint('Login OnNext Press');

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving ...'), duration: Duration(milliseconds: 300)),
      );

      if (checkLogin()) {
        Root.loadPage('/');
      } else {
        return;
      }
    }
  }


}
