import 'package:flutter/material.dart';
import 'package:laihan01/widget/button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              text: "Login",
              textColor: Colors.white,
              onPressed: () {
                // Handle login action
              },
            ),
          ],
        ),
      ),
    );
  }
}
