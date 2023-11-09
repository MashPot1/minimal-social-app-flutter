import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//simple settings page with button "sign out"
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // void changeTheme() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: OutlinedButton(
          onPressed: logout,
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(
                color: Colors.red.shade300,
                width: 1.0,
                style: BorderStyle.solid)),
          ),
          child: Text(
            'Выйти из аккаунта',
            style: TextStyle(color: Colors.red[300]),
          ),
        ),
      ),
      // SizedBox(height: 50),
      // OutlinedButton(
      //   onPressed: changeTheme,
      //   style: ButtonStyle(
      //     side: MaterialStateProperty.all(BorderSide(
      //         color: Colors.red.shade300,
      //         width: 1.0,
      //         style: BorderStyle.solid)),
      //   ),
      //   child: Text(
      //     'Сменить тему',
      //     style: TextStyle(color: Colors.red[300]),
      //   ),
      // )
    );
  }
}
