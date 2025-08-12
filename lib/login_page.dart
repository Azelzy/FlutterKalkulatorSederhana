import 'package:flutter/material.dart';
import 'package:laihan01/widget/button_widget.dart';
import 'package:laihan01/widget/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String statusLogin = "login status";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to our first App",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("please login using your email and password"),
            // image dari resource
            SizedBox(height: 15),
            Center(
              child: Image.asset(
                'assets/images/logotim.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: MyTextField(
                textEditingController: controllerUsername,
                labelText: "input username",
              ),
            ),

            MyTextField(
              textEditingController: controllerPassword,
              labelText: "input password",
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Center(
                child: CustomButton(
                  text: "Login",
                  textColor: Colors.blue,
                  onPressed: () {
                    if (controllerUsername.text == "admin" &&
                        controllerPassword.text == "admin") {
                      print("sukses login, pindah tampilan");
                    } else {
                      print("gagal login");
                    }
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Center(
                child: CustomButton(
                  text: "Register",
                  textColor: Colors.green,
                  onPressed: () {
                    print("ini register");
                  },
                ),
              ),
            ),
            Text(statusLogin),
            // button login, style nya bebas
          ],
        ),
      ),
    );
  }
}
