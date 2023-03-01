import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    await showErrorDialog(
                      context,
                      'The password provided is too weak.',
                    );
                  } else if (e.code == 'email-already-in-use') {
                    await showErrorDialog(
                      context,
                      'The account already exists for that email.',
                    );
                  } else {
                    devtools.log(e.code);
                    await showErrorDialog(context, 'Error: ${e.code}');
                  }
                } catch (e) {
                  await showErrorDialog(context, 'Error: ${e.toString()}');
                }
              },
              child: const Text('Register')),
          TextButton(
              child: const Text('Already have an account'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              })
        ],
      ),
    );
  }
}
