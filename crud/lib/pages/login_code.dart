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

  String? errorMessage = '';

  Future<bool> checkLogin() async {
    if (email == null || password == null) return false;

    debugPrint('email: $email');
    debugPrint('password: $password');

    await Authentication().loginWithPassword(email: email!, password: password!);
    return Authentication().isLogined;
  }

  void onNext(BuildContext context) async {
    debugPrint('Login OnNext Press');

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checking ...'), duration: Duration(milliseconds: 300)),
      );

      if (await checkLogin()) {
        print ('Login succeeded!');
        Root.loadPage('/');
      } else {
        print ('Login failed!');
        errorMessage = 'Invalid username/password';
        refreshView();
      }
    }
  }


}
