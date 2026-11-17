import 'package:flutter/material.dart';

import 'package:fedfer/view.dart';
import 'login_code.dart';

import '/model/db_manager.dart';
import '/debug.dart';

class LoginView extends FedView {
  const LoginView({super.key, required super.code});

  @override
  Widget build(BuildContext context) {
    LoginCode viewCode = super.code as LoginCode;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewCode.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    Text('Fedfer - Fast Event Driven for Flutter', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 16.0),
                    Text('Fedfer Samples System', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 16.0),
                    Text('CRUD', style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
                const SizedBox(height: 120.0),
                // [Name]
                TextFormField(
                  decoration: const InputDecoration(
                    // Removed filled: true
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an email/username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewCode.email = value?.trim() ?? '';
                  },
                ),
                // spacer
                const SizedBox(height: 12.0),
                // [Password]
                TextFormField(
                  decoration: const InputDecoration(
                    // Removed filled: true
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    viewCode.password = value?.trim() ?? '';
                  },
                ),
                const SizedBox(height: 12.0),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                      ),
                      child: const Text('Download DB'),
                      onPressed: () {
                        downloadDatabase(DBManager.defaultDb.databaseName);
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                      ),
                      child: const Text('CANCEL'),
                      onPressed: () {
                        viewCode.formKey.currentState?.reset();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8.0,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                      ),
                      onPressed: () => viewCode.onNext(context),
                      child: const Text('NEXT'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
