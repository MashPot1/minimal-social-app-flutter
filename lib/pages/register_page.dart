import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialapp/components/custom_button.dart';
import 'package:minimalsocialapp/components/custom_textfield.dart';
import 'package:minimalsocialapp/utils/error_message.dart';

// login page with 4 text fields "username", "email", "password" and "confirm password" and 2 buttons "already registered?" and register
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();

  void register() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != passwordConfirmController.text) {
      Navigator.pop(context);

      displayMessageToUser('Пароли не совпадают', context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        createUserDocument(userCredential);

        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        if (e.code == 'email-already-in-use') {
          displayMessageToUser('Не удалось зарегистрироваться!', context);
        }
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.person,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const Text(
              'SOCIAL APP',
              style: TextStyle(fontSize: 16, letterSpacing: 8),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                hintText: 'Имя пользователя',
                obscureText: false,
                textController: usernameController),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
                hintText: 'Почта',
                obscureText: false,
                textController: emailController),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
                hintText: 'Пароль',
                obscureText: true,
                textController: passwordController),
            const SizedBox(
              height: 25,
            ),
            CustomTextField(
                hintText: 'Повторите пароль',
                obscureText: true,
                textController: passwordConfirmController),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomButton(text: 'Зарегистрироваться', onTap: register),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Есть аккаунт? ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Войти.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 2),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
