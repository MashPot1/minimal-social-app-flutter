import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialapp/components/custom_button.dart';
import 'package:minimalsocialapp/components/custom_textfield.dart';
import 'package:minimalsocialapp/utils/error_message.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displayMessageToUser('Не удалось войти!', context);
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Забыли пароль?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            CustomButton(text: 'Войти', onTap: login),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Нет аккаунта? ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Зарегистрироваться.',
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
