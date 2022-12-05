import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/helpers/data_validators.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/pages/signup_page.dart';
import 'package:notes/reusable_widget/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordShown = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcome.jpeg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
            children: [
              SizedBox(
                  height: 290
              ),
                TextFormField(
                  controller: _emailController,
                  validator: DataValidator.isValidEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email Address",
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 0),
                    ),
                    ),
                  ),

                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isPasswordShown,
                  style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(30.0),
                      borderSide: const BorderSide(width: 0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                signInButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpButton()
              ],
            ),
        ),

    );}

  Row signUpButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Don't have an account?",
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Text("Sign Up")),
    ]);
  }
}
